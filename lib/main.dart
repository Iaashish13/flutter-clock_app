import 'package:clock_app/models/enums.dart';
import 'package:clock_app/models/menu_info.dart';
import 'package:clock_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (context) => MenuInfo(menuType: MenuType.clock),
          child: HomeScreen()),
    );
  }
}
