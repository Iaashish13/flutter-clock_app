import 'package:clock_app/constants.dart';
import 'package:clock_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({Key? key}) : super(key: key);

  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  final _isHours = true;
  bool isStopwatchStarted = true;
  bool isStopwatchStopped = true;
  bool isStopwatchReset = true;
  @override
  void dispose() {
    _stopWatchTimer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              'Stopwatch',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.topCenter,
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snapshot) {
                  final value = snapshot.data;
                  final displayTime =
                      StopWatchTimer.getDisplayTime(value!, hours: _isHours);
                  return Text(
                    displayTime,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'OpenSans',
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.topLeft,
              child: StreamBuilder<List<StopWatchRecord>>(
                stream: _stopWatchTimer.records,
                initialData: _stopWatchTimer.records.value,
                builder: (context, snapshot) {
                  final value = snapshot.data!;
                  if (value.isEmpty) {
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: value.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final data = value[index];
                      return Column(
                        children: <Widget>[
                          Text(
                            '${index + 1} - ${data.displayTime}',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 24.0,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.white30,
                            indent: 10,
                            endIndent: 20,
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 64.0,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    NewButtons(
                        name: 'Reset',
                        onPressed: () {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                        },
                        primaryColor: kClockMainColor),
                    Spacer(),
                    NewButtons(
                        name: 'Lap',
                        onPressed: () {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                        },
                        primaryColor: kClockMainColor),
                  ],
                ),
                SizedBox(
                  height: 32.0,
                ),
                Row(
                  children: <Widget>[
                    NewButtons(
                      name: 'Start',
                      onPressed: () {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                      },
                      primaryColor: kClockMainColor,
                    ),
                    Spacer(),
                    NewButtons(
                      name: 'Stop',
                      onPressed: () {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                      },
                      primaryColor: kClockMainColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
