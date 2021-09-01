import 'package:flutter/foundation.dart';

import 'package:clock_app/models/enums.dart';

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String? title;
  String? imageSource;
  MenuInfo({required this.menuType, this.title, this.imageSource});

  updateMenu(MenuInfo menuInfo) {
    this.menuType = menuInfo.menuType;
    this.title = menuInfo.title;
    this.imageSource = menuInfo.imageSource;
    notifyListeners();
  }
}
