import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_inquiry/entities/remote/get_weather_forecast.dart';
import 'package:weather_inquiry/repository/weather_forecast_repository.dart';

final weatherForecastRepositoryProvider = Provider((ref) => WeatherForecastRepository());

final headerParametersProvider =
    StateNotifierProvider<HeaderParameters, Map<String, dynamic>>((ref) {
  return HeaderParameters();
});

class HeaderParameters extends StateNotifier<Map<String, dynamic>> {
  HeaderParameters()
      : super({
          "locationName": "",
        });

  void updateLocations(String value) {
    state["locationName"] = value;
  }
}

final weatherForecastProvider = FutureProvider.autoDispose<WeatherForecast>((ref) async {
  final Map<String, dynamic> parameters = ref.watch(headerParametersProvider);

  final weatherForecastRepository = ref.watch(weatherForecastRepositoryProvider);
  final weatherForecast = await weatherForecastRepository.get36HoursWeatherForecast(
    parameters,
  );

  return weatherForecast;
});
