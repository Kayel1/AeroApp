import 'package:flutter/material.dart';
import 'dart:ui' show FontFeature;

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.title, required this.value, this.statusColor});
  final String title;
  final String value;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: statusColor ?? cs.outlineVariant, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SizedBox(
            width: 120,
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}


