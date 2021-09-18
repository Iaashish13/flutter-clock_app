import 'dart:async';

import 'package:clock_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:clock_app/constants.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int currentHrValue = 0;
  int currentMinValue = 0;
  int currentSecValue = 0;
  int timeForTimer = 0;
  String timeToDisplay = "";
  bool isStarted = true;
  bool isStopped = true;
  bool checkTimer = true;

  void start() {
    setState(() {
      isStarted = false;
      isStopped = false;
    });
    timeForTimer =
        (currentHrValue * 60 * 60) + (currentMinValue * 60) + currentSecValue;
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (mounted) // Used mounted to cancel timer

        setState(() {
          if (timeForTimer < 1 || checkTimer == false) {
            timer.cancel();
            checkTimer = true;
            timeToDisplay = "";
            isStarted = true;
            isStopped = true;
          } else if (timeForTimer < 60) {
            timeToDisplay = timeForTimer.toString().padLeft(2, "0");
            timeForTimer = timeForTimer - 1;
          } else if (timeForTimer < 3600) {
            int m = timeForTimer ~/ 60;
            int s = timeForTimer - (60 * m);
            timeToDisplay = m.toString() + ":" + s.toString();
            timeForTimer = timeForTimer - 1;
          } else {
            int h = timeForTimer ~/ 3600;
            int t = timeForTimer - (h * 3600);
            int m = t ~/ 60;
            int s = t - (60 * m);
            timeToDisplay =
                h.toString() + ":" + m.toString() + ":" + s.toString();
            timeForTimer = timeForTimer - 1;
          }
        });
    });
  }

  void stop() {
    setState(() {
      isStarted = true;
      isStopped = true;
      checkTimer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 32.0),
              child: Text(
                'Timer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Container(
              alignment: Alignment.topCenter,
              child: Text(
                timeToDisplay,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Hr',
                      style: kHmsStyle,
                    ),
                    NumberPicker(
                        textStyle: kUnselectedTextStyle,
                        selectedTextStyle: kSelectedTextSyle,
                        itemWidth: MediaQuery.of(context).size.width / 4,
                        itemHeight: MediaQuery.of(context).size.height / 10,
                        minValue: 0,
                        maxValue: 23,
                        value: currentHrValue,
                        onChanged: (value) {
                          setState(() {
                            currentHrValue = value;
                          });
                        }),
                  ],
                ),
                VerticalDivider(
                  color: Colors.white30,
                  width: 1.0,
                  indent: 5.0,
                  endIndent: 40.0,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Min',
                      style: kHmsStyle,
                    ),
                    NumberPicker(
                        selectedTextStyle: kSelectedTextSyle,
                        textStyle: kUnselectedTextStyle,
                        itemWidth: MediaQuery.of(context).size.width / 4,
                        itemHeight: MediaQuery.of(context).size.height / 10,
                        minValue: 0,
                        maxValue: 59,
                        value: currentMinValue,
                        onChanged: (value) {
                          setState(() {
                            currentMinValue = value;
                          });
                        }),
                  ],
                ),
                VerticalDivider(
                  color: Colors.white30,
                  width: 1.0,
                  indent: 5.0,
                  endIndent: 40.0,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Sec',
                      style: kHmsStyle,
                    ),
                    NumberPicker(
                        textStyle: kUnselectedTextStyle,
                        selectedTextStyle: kSelectedTextSyle,
                        itemWidth: MediaQuery.of(context).size.width / 4,
                        itemHeight: MediaQuery.of(context).size.height / 10,
                        minValue: 0,
                        maxValue: 59,
                        value: currentSecValue,
                        onChanged: (value) {
                          setState(() {
                            currentSecValue = value;
                          });
                        }),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 32.0),
              child: Row(
                children: [
                  NewButtons(
                    name: 'Start',
                    onPressed: isStarted ? start : null,
                    primaryColor: kClockMainColor,
                  ),
                  SizedBox(
                    width: 36.0,
                  ),
                  NewButtons(
                    name: 'Stop',
                    onPressed: isStopped ? null : stop,
                    primaryColor: kClockMainColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
