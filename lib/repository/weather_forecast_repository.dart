import 'package:weather_inquiry/entities/remote/get_weather_forecast.dart';
import 'package:weather_inquiry/http_handler.dart';

class WeatherForecastRepository {
  Future<WeatherForecast> get36HoursWeatherForecast(Map<String, dynamic> headers) async {
    try {
      final response = await HttpHandler().getRequest("/v1/rest/datastore/F-C0032-001", headers);

      WeatherForecast weatherForecast = WeatherForecast.fromJson(response);

      return weatherForecast;
    } catch (err, s) {
      throw Error.throwWithStackTrace(err, s); // return AsyncValue.error(err, s);
    }
  }
}
