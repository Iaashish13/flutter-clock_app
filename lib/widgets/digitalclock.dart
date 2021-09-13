import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DigitalClockWidget extends StatefulWidget {
  DigitalClockWidget({Key? key}) : super(key: key);

  @override
  _DigitalClockWidgetState createState() => _DigitalClockWidgetState();
}

class _DigitalClockWidgetState extends State<DigitalClockWidget> {
  var formattedTime = DateFormat.Hm().format(DateTime.now());
  Timer? _timer;
  @override
  void initState() {
    this._timer = Timer.periodic(Duration(seconds: 1), (timer) {
      var previousMinute = DateTime.now().add(Duration(seconds: -1)).minute;
      var currentMinute = DateTime.now().minute;
      if (previousMinute != currentMinute)
        setState(() {
          formattedTime = DateFormat.Hm().format(DateTime.now());
        });
    });
    super.initState();
  }

  @override
  void dispose() {
    this._timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedTime,
      style: TextStyle(
        color: Colors.white,
        fontSize: 64.0,
        fontFamily: 'OpenSans',
      ),
    );
  }
}
