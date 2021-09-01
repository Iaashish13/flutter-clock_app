import 'package:clock_app/models/enums.dart';
import 'package:clock_app/models/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(
      menuType: MenuType.clock,
      title: 'Clock',
      imageSource: 'assets/images/clock_icon.png'),
  MenuInfo(
      menuType: MenuType.alarm,
      title: 'Alarm',
      imageSource: 'assets/images/alarm_icon.png'),
  MenuInfo(
      menuType: MenuType.timer,
      title: 'Timer',
      imageSource: 'assets/images/timer_icon.png'),
  MenuInfo(
      menuType: MenuType.stopwatch,
      title: 'Stopwatch',
      imageSource: 'assets/images/stopwatch_icon.png'),
];
