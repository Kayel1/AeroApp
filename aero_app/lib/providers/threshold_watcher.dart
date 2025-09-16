import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/notification_service.dart';
import 'sensors_providers.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class ThresholdWatcher {
  ThresholdWatcher(this._ref) {
    _subscription = _ref.read(sensorSnapshotProvider.stream).listen((snapshot) {
      if (!snapshot.temperatureOk) {
        _ref.read(notificationServiceProvider).sendLocalLike(
              'Temperature Alert',
              'Temp ${snapshot.temperatureC.toStringAsFixed(1)}°C is out of range',
            );
      }
      if (!snapshot.humidityOk) {
        _ref.read(notificationServiceProvider).sendLocalLike(
              'Humidity Alert',
              'Humidity ${snapshot.humidityPct.toStringAsFixed(1)}% is out of range',
            );
      }
    });
  }

  final Ref _ref;
  late final StreamSubscription _subscription;

  void dispose() {
    _subscription.cancel();
  }
}

final thresholdWatcherProvider = Provider<ThresholdWatcher>((ref) {
  final watcher = ThresholdWatcher(ref);
  ref.onDispose(watcher.dispose);
  return watcher;
});


