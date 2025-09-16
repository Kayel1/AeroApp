import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/sensor_stream_service.dart';
import '../models/sensor_snapshot.dart';

final sensorStreamServiceProvider = Provider<SensorStreamService>((ref) {
  return SensorStreamService();
});

final sensorSnapshotProvider = StreamProvider<SensorSnapshot>((ref) {
  final service = ref.watch(sensorStreamServiceProvider);
  return service.stream;
});


