import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import '../models/sensor_snapshot.dart';

class SensorStreamService {
  SensorStreamService() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) => _tick());
  }

  final StreamController<SensorSnapshot> _controller = StreamController.broadcast();
  late final Timer _timer;
  final Random _rnd = Random();
  final List<FlSpot> _temp = [];
  final List<FlSpot> _hum = [];
  final List<FlSpot> _ec = [];
  final List<FlSpot> _ph = [];
  final List<FlSpot> _light = [];
  double _t = 0;

  Stream<SensorSnapshot> get stream => _controller.stream;

  void _tick() {
    _t += 1;
    final temp = 20 + 5 * sin(_t / 5) + _rnd.nextDouble();
    final hum = 60 + 15 * cos(_t / 7) + _rnd.nextDouble() * 2;
    final ec = 1.6 + 0.3 * sin(_t / 9) + (_rnd.nextDouble() - 0.5) * 0.1; // mS/cm
    final ph = 6.0 + 0.4 * cos(_t / 11) + (_rnd.nextDouble() - 0.5) * 0.1;
    final light = 7000 + 1500 * (sin(_t / 4) + 1) + _rnd.nextDouble() * 200; // lux

    _temp.add(FlSpot(_t, temp));
    _hum.add(FlSpot(_t, hum));
    _ec.add(FlSpot(_t, ec));
    _ph.add(FlSpot(_t, ph));
    _light.add(FlSpot(_t, light));
    if (_temp.length > 60) _temp.removeAt(0);
    if (_hum.length > 60) _hum.removeAt(0);
    if (_ec.length > 60) _ec.removeAt(0);
    if (_ph.length > 60) _ph.removeAt(0);
    if (_light.length > 60) _light.removeAt(0);

    final snapshot = SensorSnapshot(
      temperatureC: temp,
      humidityPct: hum,
      nutrientStatus: temp > 28 ? 'Low EC' : 'OK',
      ecMs: ec,
      ph: ph,
      lightLux: light,
      temperatureOk: temp >= 18 && temp <= 28,
      humidityOk: hum >= 50 && hum <= 75,
      nutrientsOk: temp <= 28,
      ecOk: ec >= 1.2 && ec <= 2.4,
      phOk: ph >= 5.5 && ph <= 6.5,
      lightOk: light >= 6000 && light <= 12000,
      temperatureSeries: List.of(_temp),
      humiditySeries: List.of(_hum),
      ecSeries: List.of(_ec),
      phSeries: List.of(_ph),
      lightSeries: List.of(_light),
    );
    _controller.add(snapshot);
  }

  void dispose() {
    _timer.cancel();
    _controller.close();
  }
}


