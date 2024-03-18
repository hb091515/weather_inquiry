class WeatherData {
  final String startTime;
  final String endTime;
  final String wx;
  final String pop;
  final String ci;
  final String minT;
  final String maxT;
  final String imageValue;
  WeatherData(
      {required this.startTime,
      required this.endTime,
      required this.wx,
      required this.pop,
      required this.ci,
      required this.minT,
      required this.maxT,
      required this.imageValue});

  WeatherData copyWith({
    String? startTime,
    String? endTime,
    String? wx,
    String? pop,
    String? ci,
    String? minT,
    String? maxT,
    String? imageValue,
  }) {
    return WeatherData(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      wx: wx ?? this.wx,
      pop: pop ?? this.pop,
      ci: ci ?? this.ci,
      minT: minT ?? this.minT,
      maxT: maxT ?? this.maxT,
      imageValue: imageValue ?? this.imageValue,
    );
  }
}
