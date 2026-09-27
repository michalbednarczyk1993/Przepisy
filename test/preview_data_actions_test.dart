import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book/features/preview/data/preview_data_service.dart';
import 'package:recipe_book/features/preview/presentation/preview_data_actions_web.dart';
import 'package:recipe_book/persistence/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  testWidgets('successful demo load notifies the recipe list', (tester) async {
    var notifications = 0;
    await tester.pumpWidget(
      _testApp(
        service: PreviewDataService(database),
        onDataChanged: () => notifications++,
      ),
    );

    await _startDemoLoad(tester);
    await tester.pumpAndSettle();

    expect(notifications, 1);
    expect(find.text('Wczytano dane demonstracyjne.'), findsOneWidget);
  });

  testWidgets('completed demo load does not notify a disposed screen', (
    tester,
  ) async {
    final completion = Completer<void>();
    var notifications = 0;
    await tester.pumpWidget(
      _testApp(
        service: _DelayedPreviewDataService(database, completion),
        onDataChanged: () => notifications++,
      ),
    );

    await _startDemoLoad(tester);
    await tester.pumpWidget(const SizedBox.shrink());
    completion.complete();
    await tester.pump();

    expect(notifications, 0);
    expect(tester.takeException(), isNull);
  });
}

Widget _testApp({
  required PreviewDataService service,
  required VoidCallback onDataChanged,
}) {
  return ProviderScope(
    overrides: [previewDataServiceProvider.overrideWithValue(service)],
    child: MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [PreviewDataActions(onDataChanged: onDataChanged)],
        ),
      ),
    ),
  );
}

Future<void> _startDemoLoad(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.science_outlined));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Wczytaj dane demo'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Wczytaj'));
  await tester.pump();
}

class _DelayedPreviewDataService extends PreviewDataService {
  _DelayedPreviewDataService(super.database, this.completion);

  final Completer<void> completion;

  @override
  Future<void> loadDemo() => completion.future;
}
