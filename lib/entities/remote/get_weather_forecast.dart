import 'package:flutter/material.dart';

class WeatherForecast {
  final String success;
  final Records records;

  WeatherForecast({
    required this.success,
    required this.records,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    try {
      return WeatherForecast(success: json["success"], records: Records.fromJson(json["records"]));
    } catch (err, s) {
      debugPrint('error at Weather.fromJson $err');
      Error.throwWithStackTrace(err, s);
    }
  }
}

class Records {
  final String datasetDescription;
  final List<Location> location;

  Records({
    required this.datasetDescription,
    required this.location,
  });

  factory Records.fromJson(Map<String, dynamic> json) {
    try {
      var dataJson = json["location"] as List;

      List<Location> data =
          dataJson.isNotEmpty ? dataJson.map((e) => Location.fromJson(e)).toList() : [];

      return Records(datasetDescription: json["datasetDescription"], location: data);
    } catch (err, s) {
      debugPrint('error at Records.fromJson $err');
      Error.throwWithStackTrace(err, s);
    }
  }
}

class Location {
  final String locationName;
  final List<WeatherElement> weatherElement;

  Location({
    required this.locationName,
    required this.weatherElement,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    try {
      var dataJson = json["weatherElement"] as List;

      List<WeatherElement> data =
          dataJson.isNotEmpty ? dataJson.map((e) => WeatherElement.fromJson(e)).toList() : [];

      return Location(locationName: json["locationName"], weatherElement: data);
    } catch (err, s) {
      debugPrint('error at Location.fromJson $err');
      Error.throwWithStackTrace(err, s);
    }
  }
}

class WeatherElement {
  final String elementName;
  final List<Time> time;

  WeatherElement({
    required this.elementName,
    required this.time,
  });

  factory WeatherElement.fromJson(Map<String, dynamic> json) {
    try {
      var dataJson = json["time"] as List;

      List<Time> data = dataJson.isNotEmpty ? dataJson.map((e) => Time.fromJson(e)).toList() : [];
      return WeatherElement(elementName: json["elementName"], time: data);
    } catch (err, s) {
      debugPrint('error at WeatherElement.fromJson $err');
      Error.throwWithStackTrace(err, s);
    }
  }
}

class Time {
  final String startTime;
  final String endTime;
  final Parameter parameter;

  Time({
    required this.startTime,
    required this.endTime,
    required this.parameter,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    try {
      return Time(
          startTime: json["startTime"],
          endTime: json["endTime"],
          parameter: Parameter.fromJson(json["parameter"]));
    } catch (err, s) {
      debugPrint('error at Time.fromJson $err');
      Error.throwWithStackTrace(err, s);
    }
  }
}

class Parameter {
  final String parameterName;
  final String parameterValue;
  final String parameterUnit;

  Parameter({
    required this.parameterName,
    required this.parameterValue,
    required this.parameterUnit,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) {
    try {
      final String parameterValue =
          json.containsKey("parameterValue") ? json["parameterValue"] : "";
      final String parameterUnit = json.containsKey("parameterUnit") ? json["parameterUnit"] : "";
      return Parameter(
          parameterName: json["parameterName"],
          parameterValue: parameterValue,
          parameterUnit: parameterUnit);
    } catch (err, s) {
      debugPrint('error at Parameter.fromJson $err');

      Error.throwWithStackTrace(err, s);
    }
  }
}
