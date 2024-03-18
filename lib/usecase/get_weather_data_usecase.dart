import 'package:weather_inquiry/entities/local/weather_data.dart';
import 'package:weather_inquiry/entities/remote/get_weather_forecast.dart';
import 'package:weather_inquiry/utils/cast_chinese.dart';

class GetWeatherDataUsecase {
  List<WeatherData> call(WeatherForecast weatherForecast) {
    // List<WeatherElement> weatherElements = weatherForecast.records.location
    //     .firstWhere((element) => element.locationName == location)
    //     .weatherElement;
    List<WeatherElement> weatherElements = weatherForecast.records.location[0].weatherElement;

    final allTimeData = weatherElements.expand((element) => element.time).toList();

    final uniqueTimeKeys = allTimeData.fold<List<String>>([], (acc, time) {
      final key = '${time.startTime}-${time.endTime}';
      if (!acc.contains(key)) {
        acc.add(key);
      }
      return acc;
    });

    final weatherDataList = uniqueTimeKeys.map((timeKey) {
      final startTime = allTimeData
          .firstWhere((time) => '${time.startTime}-${time.endTime}' == timeKey)
          .startTime;
      final endTime =
          allTimeData.firstWhere((time) => '${time.startTime}-${time.endTime}' == timeKey).endTime;

      return WeatherData(
        startTime: startTime,
        endTime: endTime,
        wx: "",
        pop: "",
        ci: "",
        minT: "",
        maxT: "",
        imageValue: "",
      );
    }).toList();

    final wxList = weatherElements.firstWhere((element) => element.elementName == "Wx").time;
    final popList = weatherElements.firstWhere((element) => element.elementName == "PoP").time;
    final ciList = weatherElements.firstWhere((element) => element.elementName == "CI").time;
    final minTList = weatherElements.firstWhere((element) => element.elementName == "MinT").time;
    final maxTList = weatherElements.firstWhere((element) => element.elementName == "MaxT").time;

    for (int i = 0; i < weatherDataList.length; i++) {
      weatherDataList[i] = weatherDataList[i].copyWith(
        wx: wxList[i].parameter.parameterName,
        pop:
            "${popList[i].parameter.parameterName}${CastChinese().getUnit(popList[i].parameter.parameterUnit)}",
        ci: ciList[i].parameter.parameterName,
        minT:
            "${minTList[i].parameter.parameterName}${CastChinese().getUnit(minTList[i].parameter.parameterUnit)}",
        maxT:
            "${maxTList[i].parameter.parameterName}${CastChinese().getUnit(maxTList[i].parameter.parameterUnit)}",
        imageValue: wxList[i].parameter.parameterValue,
      );
    }

    return weatherDataList;
  }
}
