import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_inquiry/providers/weather_data_provider.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                // width: 300,
                // height: 300,
                child: Lottie.asset(
                  'assets/lottie/notFound.json',
                  fit: BoxFit.fill,
                  frameRate: FrameRate.max,
                ),
              ),
              Text(
                "找不到${widget.title}相關的氣象資訊喔！\n請檢查網路是否連線異常",
              ),
              Padding(padding: EdgeInsets.all(2)),
              ElevatedButton(
                  onPressed: () async {
                    ref.refresh(weatherForecastProvider);
                  },
                  child: Text("重試")),
            ],
          ),
        );
      },
    );
  }
}
