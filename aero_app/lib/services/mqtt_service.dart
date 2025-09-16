import 'dart:async';
import 'dart:convert';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../models/sensor_snapshot.dart';

class MqttIoTService {
  MqttServerClient? _client;

  Future<void> connect({required String broker, required String clientId, int port = 1883, String? username, String? password}) async {
    _client = MqttServerClient(broker, clientId);
    _client!.port = port;
    _client!.logging(on: false);
    _client!.keepAlivePeriod = 20;
    _client!.onDisconnected = () {};
    final connMessage = MqttConnectMessage().withClientIdentifier(clientId).startClean();
    _client!.connectionMessage = connMessage;
    await _client!.connect(username, password);
  }

  Stream<SensorSnapshot> subscribeSensors(String topic) async* {
    _client!.subscribe(topic, MqttQos.atMostOnce);
    await for (final event in _client!.updates!) {
      final rec = event.first;
      final payload = (rec.payload as MqttPublishMessage).payload.message;
      final jsonStr = utf8.decode(payload);
      final map = json.decode(jsonStr) as Map<String, dynamic>;
      final temp = (map['temperatureC'] ?? 24).toDouble();
      final hum = (map['humidityPct'] ?? 60).toDouble();
      yield SensorSnapshot(
        temperatureC: temp,
        humidityPct: hum,
        nutrientStatus: (map['nutrientStatus'] ?? 'OK').toString(),
        temperatureOk: temp >= 18 && temp <= 28,
        humidityOk: hum >= 50 && hum <= 75,
        nutrientsOk: (map['nutrientsOk'] ?? true) == true,
        temperatureSeries: const [],
        humiditySeries: const [],
      );
    }
  }

  Future<void> publishActuators(String topic, {bool? pump, bool? mist, bool? lights, double? fanSpeed}) async {
    final builder = MqttClientPayloadBuilder();
    builder.addString(json.encode({
      if (pump != null) 'pumpOn': pump,
      if (mist != null) 'mistOn': mist,
      if (lights != null) 'lightsOn': lights,
      if (fanSpeed != null) 'fanSpeed': fanSpeed,
    }));
    _client!.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }
}


