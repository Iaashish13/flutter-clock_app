import 'package:clock_app/constants.dart';
import 'package:clock_app/models/enums.dart';
import 'package:clock_app/list.dart';
import 'package:clock_app/models/menu_info.dart';
import 'package:clock_app/screens/clock_page.dart';

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
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (
                context,
                menuInfo,
                Widget? child,
              ) {
                if (menuInfo.menuType != MenuType.clock)
                  return Container(
                    color: Colors.black,
                  );
                return ClockPage();
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
