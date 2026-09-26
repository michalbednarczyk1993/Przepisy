import 'package:flutter/widgets.dart';

class PreviewDataActions extends StatelessWidget {
  const PreviewDataActions({required this.onDataChanged, super.key});

  final VoidCallback onDataChanged;

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
