import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/sensor_snapshot.dart';

class FirebaseRealtimeService {
  FirebaseApp? _app;
  DatabaseReference? _root;

  Future<void> initialize({FirebaseOptions? options}) async {
    _app ??= await Firebase.initializeApp(options: options);
    _root = FirebaseDatabase.instance.ref();
  }

  Stream<SensorSnapshot> sensorStream() {
    final ref = _root!.child('sensors');
    return ref.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      final temp = (data['temperatureC'] ?? 24).toDouble();
      final hum = (data['humidityPct'] ?? 60).toDouble();
      // For charts, you would maintain series client-side; this stream focuses on latest values.
      return SensorSnapshot(
        temperatureC: temp,
        humidityPct: hum,
        nutrientStatus: (data['nutrientStatus'] ?? 'OK').toString(),
        temperatureOk: temp >= 18 && temp <= 28,
        humidityOk: hum >= 50 && hum <= 75,
        nutrientsOk: (data['nutrientsOk'] ?? true) == true,
        temperatureSeries: const [],
        humiditySeries: const [],
      );
    });
  }

  Future<void> setActuators({bool? pump, bool? mist, bool? lights, double? fanSpeed}) async {
    final ref = _root!.child('actuators');
    await ref.update({
      if (pump != null) 'pumpOn': pump,
      if (mist != null) 'mistOn': mist,
      if (lights != null) 'lightsOn': lights,
      if (fanSpeed != null) 'fanSpeed': fanSpeed,
    });
  }
}


