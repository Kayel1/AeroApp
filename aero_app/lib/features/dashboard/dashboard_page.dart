import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/sensors_providers.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/status_badge.dart';
import '../../utils/format.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  Color _statusColor(bool inRange) => inRange ? Colors.green : Colors.red;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(sensorSnapshotProvider);

    return snapshot.when(
      data: (data) {
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList.list(children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    StatCard(title: 'Temperature', value: formatTemperatureC(data.temperatureC), statusColor: _statusColor(data.temperatureOk)),
                    StatCard(title: 'Humidity', value: formatHumidityPct(data.humidityPct), statusColor: _statusColor(data.humidityOk)),
                    StatCard(title: 'EC', value: '${data.ecMs.toStringAsFixed(2)} mS/cm', statusColor: _statusColor(data.ecOk)),
                    StatCard(title: 'pH', value: data.ph.toStringAsFixed(2), statusColor: _statusColor(data.phOk)),
                    StatCard(title: 'Light', value: '${data.lightLux.toStringAsFixed(0)} lx', statusColor: _statusColor(data.lightOk)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    StatusBadge(ok: data.temperatureOk),
                    const SizedBox(width: 8),
                    StatusBadge(ok: data.humidityOk),
                    const SizedBox(width: 8),
                    StatusBadge(ok: data.ecOk),
                    const SizedBox(width: 8),
                    StatusBadge(ok: data.phOk),
                    const SizedBox(width: 8),
                    StatusBadge(ok: data.lightOk),
                  ],
                ),
                const SizedBox(height: 16),
                _ChartCard(
                  title: 'Temperature (last 60m)',
                  points: data.temperatureSeries,
                  labelFormatter: (v) => v.toStringAsFixed(1),
                ),
                const SizedBox(height: 16),
                _ChartCard(
                  title: 'Humidity (last 60m)',
                  points: data.humiditySeries,
                  labelFormatter: (v) => v.round().toString(),
                ),
                const SizedBox(height: 16),
                _ChartCard(
                  title: 'EC (last 60m)',
                  points: data.ecSeries,
                  labelFormatter: (v) => v.toStringAsFixed(2),
                ),
                const SizedBox(height: 16),
                _ChartCard(
                  title: 'pH (last 60m)',
                  points: data.phSeries,
                  labelFormatter: (v) => v.toStringAsFixed(2),
                ),
                const SizedBox(height: 16),
                _ChartCard(
                  title: 'Light (last 60m)',
                  points: data.lightSeries,
                  labelFormatter: (v) => v.round().toString(),
                ),
              ]),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({required this.title, required this.points, this.labelFormatter});
  final String title;
  final List<FlSpot> points;
  final String Function(double)? labelFormatter;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return Container(
        height: 220,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            const Center(child: Text('No data')),
            const Spacer(),
          ],
        ),
      );
    }

    final minY = points.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    final maxY = points.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    final range = (maxY - minY).abs();
    double interval;
    if (range <= 1) {
      interval = 0.2;
    } else if (range <= 2) {
      interval = 0.5;
    } else if (range <= 5) {
      interval = 1;
    } else if (range <= 10) {
      interval = 2;
    } else {
      interval = (range / 4).ceilToDouble();
    }

    return Container(
      height: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Expanded(
            child: LineChart(
              LineChartData(
                minY: minY - range * 0.1,
                maxY: maxY + range * 0.1,
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 44,
                      interval: interval,
                      getTitlesWidget: (value, meta) {
                        final label = (labelFormatter ?? (v) => v.toStringAsFixed(1))(value);
                        return Text(label, style: Theme.of(context).textTheme.bodySmall);
                      },
                    ),
                  ),
                  bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: points,
                    isCurved: true,
                    color: Theme.of(context).colorScheme.primary,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


