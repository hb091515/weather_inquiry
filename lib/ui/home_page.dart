import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_inquiry/providers/page_status_provider.dart';
import 'package:weather_inquiry/providers/string_provider.dart';
import 'package:weather_inquiry/ui/init_page.dart';
import 'package:weather_inquiry/ui/result_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final status = ref.watch(pageStatusProvider);
    final title = ref.watch(titleProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
              onPressed: () {
                ref.read(pageStatusProvider.notifier).setStatus(HomePageStatus.init);
                ref.read(titleProvider.notifier).state = "氣象查詢";
                FocusScope.of(context).requestFocus(FocusNode());
                showSearch(
                  context: context,
                  delegate: HomePageSearchBarDelegate(),
                  query: "",
                );
              },
              icon: const Icon(Icons.search))
        ],
        centerTitle: true,
        title: Text(title),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          Widget widget = const SizedBox();
          switch (status) {
            case HomePageStatus.init:
              widget = const InitPage();
              break;
            case HomePageStatus.showResult:
              widget = const ResultPage();

              break;
          }
          return widget;
        },
      ),
    );
  }
}
