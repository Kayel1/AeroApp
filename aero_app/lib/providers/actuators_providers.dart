import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/actuator_service.dart';
import '../models/actuator_state.dart';

final actuatorServiceProvider = Provider<ActuatorService>((ref) {
  return ActuatorService();
});

class ActuatorNotifier extends Notifier<ActuatorState> {
  @override
  ActuatorState build() {
    return const ActuatorState();
  }

  void setPump(bool on) {
    state = state.copyWith(pumpOn: on);
    ref.read(actuatorServiceProvider).setPump(on);
  }

  void setMist(bool on) {
    state = state.copyWith(mistOn: on);
    ref.read(actuatorServiceProvider).setMist(on);
  }

  void setLights(bool on) {
    state = state.copyWith(lightsOn: on);
    ref.read(actuatorServiceProvider).setLights(on);
  }

  void setFanSpeed(double v) {
    state = state.copyWith(fanSpeed: v);
    ref.read(actuatorServiceProvider).setFanSpeed(v);
  }
}

final actuatorStateProvider = NotifierProvider<ActuatorNotifier, ActuatorState>(
  ActuatorNotifier.new,
);


