import 'package:clock_app/constants.dart';
import 'package:clock_app/models/enums.dart';
import 'package:clock_app/list.dart';
import 'package:clock_app/models/menu_info.dart';
import 'package:clock_app/screens/alarm_page.dart';
import 'package:clock_app/screens/clock_page.dart';
import 'package:clock_app/screens/stopwatch_page.dart';
import 'package:clock_app/screens/timer_page.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuInfo) => sideButtons(currentMenuInfo))
                .toList(),
          ),
          VerticalDivider(
            color: Colors.white30,
            width: 1.0,
            indent: 35.0,
            endIndent: 0,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (
                context,
                MenuInfo value,
                Widget? child,
              ) {
                if (value.menuType == MenuType.clock)
                  return ClockPage();
                else if (value.menuType == MenuType.alarm)
                  return AlarmPage();
                else if (value.menuType == MenuType.timer)
                  return TimerPage();
                else
                  return StopwatchPage();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget sideButtons(MenuInfo currentMenuInfo) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Consumer(
        builder: (BuildContext context, MenuInfo value, Widget? child) {
          return TextButton(
            onPressed: () {
              var menuInfo = Provider.of<MenuInfo>(
                context,
                listen: false,
              );
              menuInfo.updateMenu(currentMenuInfo);
            },
            child: Column(
              children: <Widget>[
                Image.asset(
                  currentMenuInfo.imageSource.toString(),
                  scale: 1.5,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  currentMenuInfo.title.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ],
            ),
            style: TextButton.styleFrom(
              backgroundColor: currentMenuInfo.menuType == value.menuType
                  ? kSelectedColor
                  : Colors.transparent,
              minimumSize: Size(90.0, 90.0),
            ),
          );
        },
      ),
    );
  }
}
