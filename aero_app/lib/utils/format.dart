import 'package:intl/intl.dart';

final NumberFormat _oneDec = NumberFormat('0.0');
final NumberFormat _noDec = NumberFormat('0');

String formatTemperatureC(double value) => '${_oneDec.format(value)}°C';
String formatHumidityPct(double value) => '${_noDec.format(value)}%';
String formatPercent01(double value) => '${_noDec.format(value * 100)}%';


