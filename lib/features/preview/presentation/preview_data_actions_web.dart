import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/confirm_dialog.dart';
import '../data/preview_data_service.dart';

class PreviewDataActions extends ConsumerWidget {
  const PreviewDataActions({required this.onDataChanged, super.key});

  final VoidCallback onDataChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<_PreviewAction>(
      tooltip: 'Dane testowe',
      icon: const Icon(Icons.science_outlined),
      onSelected: (action) => _run(context, ref, action),
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: _PreviewAction.loadDemo,
          child: Text('Wczytaj dane demo'),
        ),
        PopupMenuItem(value: _PreviewAction.reset, child: Text('Wyczyść dane')),
      ],
    );
  }

  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    _PreviewAction action,
  ) async {
    final confirmed = await showConfirmDialog(
      context,
      title: action == _PreviewAction.loadDemo
          ? 'Wczytać dane demonstracyjne?'
          : 'Wyczyścić dane preview?',
      message: 'Obecne przepisy i własne kategorie zostaną usunięte.',
      confirmLabel: action == _PreviewAction.loadDemo ? 'Wczytaj' : 'Wyczyść',
    );
    if (!confirmed || !context.mounted) return;

    try {
      final service = ref.read(previewDataServiceProvider);
      if (action == _PreviewAction.loadDemo) {
        await service.loadDemo();
      } else {
        await service.reset();
      }
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nie udało się zmienić danych preview.')),
      );
      return;
    }
    if (!context.mounted) return;
    onDataChanged();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          action == _PreviewAction.loadDemo
              ? 'Wczytano dane demonstracyjne.'
              : 'Wyczyszczono dane preview.',
        ),
      ),
    );
  }
}

enum _PreviewAction { loadDemo, reset }
