import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key, required this.onGetStarted});
  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cs.primaryContainer, cs.surface],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  'Automated IoT-Based\nAeroponic System',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Monitor and control aeroponic environments in real time. \nSensors (temperature, humidity, pH, nutrients) stream live to your phone. Control pumps, mist sprayers, fans, and lights with safety alerts when values exceed optimal ranges.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 24),
                _Highlights(),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onGetStarted,
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Get Started'),
                    style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'Capstone Project • 2025',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Highlights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = const [
      (Icons.show_chart_rounded, 'Live charts & trends'),
      (Icons.sensors_rounded, 'Real-time sensor readings'),
      (Icons.tune_rounded, 'Manual overrides for actuators'),
      (Icons.notifications_active_rounded, 'Alerts when out of range'),
    ];
    return Wrap(
      runSpacing: 12,
      spacing: 12,
      children: [
        for (final item in items)
          _Chip(icon: item.$1, label: item.$2),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
        boxShadow: [
          BoxShadow(color: cs.shadow.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: cs.primary),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}


