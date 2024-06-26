import 'package:easy_localization/easy_localization.dart';
import 'package:elaser/view/screens/convert_pic.dart';
import 'package:elaser/view/screens/upload_file_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DashboardProvider extends ChangeNotifier {
  int _index = 0;
  int _lastIndex = 0;

  final List<Widget> _screens = [
    const ConvertPicWebViewScreen(),
    const UploadFileScreen(),
  ];

  final List<SalomonBottomBarItem> _items = [
    // SalomonBottomBarItem(
    //   // icon: Container(
    //   //   padding: const EdgeInsets.all(AppSize.paddingExtraSmall + 2),
    //   //   decoration: const BoxDecoration(
    //   //     shape: BoxShape.circle,
    //   //     color: kMainColor,
    //   //   ),
    //   //   child: Text("1", style: kBoldFontStyle.copyWith(color: Colors.white)),
    //   // ),
    //   icon: const Icon(Icons.sensors),
    //   title: Text("settings".tr()),
    // ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.photo_size_select_actual_outlined),
      title: Text("conversion".tr()),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.flip),
      title: Text("print".tr()),
    ),
  ];

  int get index => _index;

  Widget get currentScreen => _screens[_index];

  List<SalomonBottomBarItem> get salomonItems => _items;

  void updateIndex(int index) {
    if (index <= _lastIndex) {
      _index = index;
      notifyListeners();
    }
  }

  void goToNextIndex() {
    if (_index+1 < _screens.length) {
      _index++;
      if (_index > _lastIndex) {
        _lastIndex = _index;
      }
      notifyListeners();
    }
  }
}
