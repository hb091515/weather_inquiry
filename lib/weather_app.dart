import 'package:flutter/material.dart';
import 'package:weather_inquiry/ui/home_page.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<StatefulWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff071734)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
