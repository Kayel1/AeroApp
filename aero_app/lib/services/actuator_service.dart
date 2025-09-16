class ActuatorService {
  bool _pump = false;
  bool _mist = false;
  bool _lights = false;
  double _fan = 0.0;

  void setPump(bool on) {
    _pump = on;
    // TODO: send to Firebase/MQTT
  }

  void setMist(bool on) {
    _mist = on;
  }

  void setLights(bool on) {
    _lights = on;
  }

  void setFanSpeed(double v) {
    _fan = v;
  }
}


