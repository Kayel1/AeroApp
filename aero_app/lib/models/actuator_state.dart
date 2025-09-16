class ActuatorState {
  const ActuatorState({
    this.pumpOn = false,
    this.mistOn = false,
    this.lightsOn = false,
    this.fanSpeed = 0.0,
  });

  final bool pumpOn;
  final bool mistOn;
  final bool lightsOn;
  final double fanSpeed;

  ActuatorState copyWith({
    bool? pumpOn,
    bool? mistOn,
    bool? lightsOn,
    double? fanSpeed,
  }) {
    return ActuatorState(
      pumpOn: pumpOn ?? this.pumpOn,
      mistOn: mistOn ?? this.mistOn,
      lightsOn: lightsOn ?? this.lightsOn,
      fanSpeed: fanSpeed ?? this.fanSpeed,
    );
  }
}


