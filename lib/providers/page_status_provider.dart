import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageStatusProvider = StateNotifierProvider<PageStatus, HomePageStatus>((ref) => PageStatus());

class PageStatus extends StateNotifier<HomePageStatus> {
  PageStatus() : super(HomePageStatus.init);

  void setStatus(HomePageStatus newStatus) {
    state = newStatus;
  }
}

enum HomePageStatus {
  init,
  showResult,
}
