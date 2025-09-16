import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.ok});
  final bool ok;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = ok ? Colors.green : Colors.red;
    final label = ok ? 'Normal' : 'Alert';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(ok ? Icons.check_circle : Icons.error, color: color, size: 16),
          const SizedBox(width: 6),
          Text(label, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: cs.onSurface)),
        ],
      ),
    );
  }
}


