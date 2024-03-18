import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_inquiry/weather_app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: WeatherApp(),
    ),
  );
}
