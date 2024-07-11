import 'package:citizen_femme/view/profile/login.dart';
import 'package:flutter/material.dart';

class BottomBarProvider extends ChangeNotifier {
  int selectedTab = 0;
  PageStorageBucket storageBucket = PageStorageBucket();
  Widget selectPageView = LogInScreen();

  void setPageView(int index, Widget screen) {
    selectedTab = index;
    selectPageView = screen;
    notifyListeners();
  }
}
