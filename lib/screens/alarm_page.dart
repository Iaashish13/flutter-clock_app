import 'package:clock_app/alarm_helper.dart';
import 'package:clock_app/constants.dart';
import 'package:clock_app/models/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  final sound = 'test_sound.wav';

  AlarmHelper _alarmHelper = AlarmHelper();
  String? _alarmTimeString;
  DateTime? _alarmTime;
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;

  @override
  void initState() {
    tz.initializeTimeZones();
    _alarmHelper.initializeDatabase().then((value) {
      print(
        'Database Initialised',
      );
      loadAlarms();
    });

    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 48.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Alarm',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w900,
              fontFamily: 'OpenSans',
            ),
          ),
          Expanded(
            child: FutureBuilder<List<AlarmInfo>>(
              future: _alarms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _currentAlarms = snapshot.data;
                  return ListView(
                    children: snapshot.data!.map<Widget>((alarm) {
                      var alarmTime =
                          DateFormat.jm().format(alarm.alarmDateTime);
                      var gradientColor = GradientTemplate
                          .gradientTemplate[alarm.gradientColorIndex].colors;
                      return Container(
                        margin: EdgeInsets.only(bottom: 32.0),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColor,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: gradientColor.last.withOpacity(0.2),
                              blurRadius: 8.0,
                              spreadRadius: 2.0,
                              offset: Offset(4, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.label,
                                      color: Colors.white,
                                      size: 28.0,
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'Alarm',
                                      style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: true,
                                  onChanged: (value) {
                                    cancelNotification(alarm.id!);
                                  },
                                  activeColor: Colors.white,
                                ),
                              ],
                            ),
                            Text(
                              'Mon-Fri',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  alarmTime,
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    deleteAlarm(alarm.id!);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).followedBy([
                      DottedBorder(
                        strokeWidth: 3.0,
                        color: kOutlineClockColor,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(24.0),
                        dashPattern: [6, 4],
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kClockMainColor,
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _alarmTimeString =
                                  DateFormat.Hm().format(DateTime.now());

                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setModalstate) {
                                      return Container(
                                        padding: EdgeInsets.all(32.0),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        child: Column(
                                          children: <Widget>[
                                            TextButton(
                                              onPressed: () async {
                                                var selectedTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );
                                                if (selectedTime != null) {
                                                  final now = DateTime.now();
                                                  var selectedDateTime =
                                                      DateTime(
                                                    now.year,
                                                    now.month,
                                                    now.day,
                                                    selectedTime.hour,
                                                    selectedTime.minute,
                                                  );
                                                  _alarmTime = selectedDateTime;

                                                  setModalstate(() {
                                                    _alarmTimeString =
                                                        DateFormat.Hm().format(
                                                            selectedDateTime);
                                                  });
                                                }
                                              },
                                              child: Text(
                                                _alarmTimeString!,
                                                style: TextStyle(
                                                  color: kClockMainColor,
                                                  fontSize: 32.0,
                                                  fontFamily: 'OpenSans',
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text('Repeat'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            ListTile(
                                              title: Text('Title'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            ListTile(
                                              title: Text('Sound'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            SizedBox(
                                              height: 32.0,
                                            ),
                                            FloatingActionButton.extended(
                                              onPressed: () {
                                                onSaveAlarm();
                                              },
                                              icon: Icon(Icons.alarm),
                                              label: Text('Save'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/add_alarm.png',
                                  scale: 1.5,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Add Alarm',
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                24.0,
                              )),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 24.0),
                            ),
                          ),
                        ),
                      ),
                    ]).toList(),
                  );
                }

                return Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> scheduledNotification(DateTime dateTime) async {
    flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Alarm',
      'Alarm Time',
      tz.TZDateTime.from(dateTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id 50',
          'channel name',
          'channel description',
          importance: Importance.max,
          sound: RawResourceAndroidNotificationSound(sound.split('.').first),
          priority: Priority.high,
          enableVibration: false,
        ),
        iOS: IOSNotificationDetails(
          sound: sound,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  void onSaveAlarm() {
    DateTime? scheduledAlarmTime;
    if (_alarmTime!.isAfter(DateTime.now()))
      scheduledAlarmTime = _alarmTime!;
    else
      scheduledAlarmTime = _alarmTime!.add(Duration(days: 1));
    print('Time = $scheduledAlarmTime');
    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduledAlarmTime,
      gradientColorIndex: _currentAlarms!.length,
      title: 'New Alarm',
      isPending: false,
    );
    _alarmHelper.insertAlarm(alarmInfo);
    Navigator.pop(context);
    scheduledNotification(scheduledAlarmTime);
    loadAlarms();
  }

  void deleteAlarm(int id) async {
    _alarmHelper.delete(id);
    loadAlarms();
    cancelNotification(id);
  }

  void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
