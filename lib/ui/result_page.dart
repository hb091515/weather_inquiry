import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_inquiry/entities/local/weather_data.dart';
import 'package:weather_inquiry/providers/string_provider.dart';
import 'package:weather_inquiry/providers/weather_data_provider.dart';
import 'package:weather_inquiry/ui/error_page.dart';
import 'package:weather_inquiry/ui/loading_page.dart';
import 'package:weather_inquiry/usecase/get_weather_data_usecase.dart';
import 'package:weather_inquiry/utils/image_resolve.dart';
import 'package:weather_inquiry/utils/time_usecase.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<StatefulWidget> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final activity = ref.watch(weatherForecastProvider);
        final title = ref.watch(titleProvider);
        return activity.when(
          data: (weatherForecast) {
            List<WeatherData> weatherDataList = GetWeatherDataUsecase().call(weatherForecast);

            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = weatherDataList[index];
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: TimeUsecase.conventDateTime(item.startTime),
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' ~ ',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: TimeUsecase.conventDateTime(item.endTime),
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: SvgPicture.asset(
                              ImageResolver.resolveWeatherIcon(item.imageValue),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.wx,
                                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.ci,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Icon(
                                item.pop == "0%"
                                    ? CupertinoIcons.sun_max
                                    : CupertinoIcons.cloud_rain,
                                color: item.pop == "0%" ? Colors.orange : Colors.blue[300],
                                size: 30,
                              ),
                              Text(
                                item.pop,
                                style: TextStyle(
                                    color: item.pop == "0%" ? Colors.orange : Colors.blue[300],
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                item.maxT,
                                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.minT,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              itemCount: weatherDataList.length,
            );
          },
          loading: () {
            return const LoadingPage();
          },
          error: (error, stackTrace) {
            return ErrorPage(
              title: title,
            );
          },
        );
      },
    );
  }
}
