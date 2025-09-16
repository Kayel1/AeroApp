import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/actuators_providers.dart';

class ControlsPage extends ConsumerWidget {
  const ControlsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(actuatorStateProvider);
    final notifier = ref.read(actuatorStateProvider.notifier);

    final cs = Theme.of(context).colorScheme;
    Widget tile({required IconData icon, required String title, required Widget trailing}) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: Row(
          children: [
            Icon(icon, color: cs.primary),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
            trailing,
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Controls')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          tile(
            icon: Icons.invert_colors, title: 'Pump',
            trailing: Switch(value: state.pumpOn, onChanged: notifier.setPump),
          ),
          tile(
            icon: Icons.grain, title: 'Mist Sprayers',
            trailing: Switch(value: state.mistOn, onChanged: notifier.setMist),
          ),
          tile(
            icon: Icons.light_mode, title: 'Lights',
            trailing: Switch(value: state.lightsOn, onChanged: notifier.setLights),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.toys, color: cs.primary),
                    const SizedBox(width: 12),
                    Text('Fan speed', style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    Text('${(state.fanSpeed * 100).round()}%'),
                  ],
                ),
                Slider(
                  value: state.fanSpeed,
                  min: 0,
                  max: 1,
                  divisions: 10,
                  label: '${(state.fanSpeed * 100).round()}%',
                  onChanged: notifier.setFanSpeed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


