import 'package:fl_chart/fl_chart.dart';

class SensorSnapshot {
  SensorSnapshot({
    required this.temperatureC,
    required this.humidityPct,
    required this.nutrientStatus,
    required this.ecMs,
    required this.ph,
    required this.lightLux,
    required this.temperatureOk,
    required this.humidityOk,
    required this.nutrientsOk,
    required this.ecOk,
    required this.phOk,
    required this.lightOk,
    required this.temperatureSeries,
    required this.humiditySeries,
    required this.ecSeries,
    required this.phSeries,
    required this.lightSeries,
  });

  final double temperatureC;
  final double humidityPct;
  final String nutrientStatus;
  final double ecMs;
  final double ph;
  final double lightLux;
  final bool temperatureOk;
  final bool humidityOk;
  final bool nutrientsOk;
  final bool ecOk;
  final bool phOk;
  final bool lightOk;
  final List<FlSpot> temperatureSeries;
  final List<FlSpot> humiditySeries;
  final List<FlSpot> ecSeries;
  final List<FlSpot> phSeries;
  final List<FlSpot> lightSeries;
}


