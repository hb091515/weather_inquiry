import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_inquiry/locations/locations.dart';
import 'package:weather_inquiry/providers/page_status_provider.dart';
import 'package:weather_inquiry/providers/string_provider.dart';
import 'package:weather_inquiry/providers/weather_data_provider.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: Lottie.asset(
              'assets/lottie/lovely-cats.json',
              fit: BoxFit.fill,
              frameRate: FrameRate.max,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "請在上方搜尋欄中輸入您所在的地區，然後按下搜尋按鈕。您將會看到今明天36小時的天氣預報。",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageSearchBarDelegate extends SearchDelegate<String> {
  List<String> locations = Locations().locations;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
        FocusScope.of(context).unfocus();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> filteredLocations = locations.where((location) {
      final normalizedQuery = query.replaceAll("台", "臺");
      return location.contains(normalizedQuery);
    }).toList();
    if (filteredLocations.isEmpty && query.isNotEmpty) {
      return const Center(
        child: Text("找不到相關的結果"),
      );
    }
    return Consumer(
      builder: (context, ref, child) {
        return Scrollbar(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(filteredLocations[index]),
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                  ref.read(pageStatusProvider.notifier).setStatus(HomePageStatus.showResult);
                  ref.read(titleProvider.notifier).state = filteredLocations[index];
                  ref
                      .read(headerParametersProvider.notifier)
                      .updateLocations(filteredLocations[index]);
                },
              );
            },
            itemCount: filteredLocations.length,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> filteredLocations = query != ""
        ? locations.where((location) {
            final normalizedQuery = query.replaceAll("台", "臺");

            return location.contains(normalizedQuery);
          }).toList()
        : locations;

    if (filteredLocations.isEmpty && query.isNotEmpty) {
      return const Center(
        child: Text("找不到相關的結果"),
      );
    }
    return Consumer(
      builder: (context, ref, child) {
        return Scrollbar(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(filteredLocations[index]),
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                  ref.read(pageStatusProvider.notifier).setStatus(HomePageStatus.showResult);
                  ref.read(titleProvider.notifier).state = filteredLocations[index];
                  ref
                      .read(headerParametersProvider.notifier)
                      .updateLocations(filteredLocations[index]);
                },
              );
            },
            itemCount: filteredLocations.length,
          ),
        );
      },
    );
  }
}
