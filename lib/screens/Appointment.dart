import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import '../Utils/text_view.dart';
import '../utils/app_colors.dart';
import 'home_screen.dart';

class AppointmentReminderScreen extends StatefulWidget {
  @override
  _AppointmentReminderScreenState createState() =>
      _AppointmentReminderScreenState();
}

class _AppointmentReminderScreenState extends State<AppointmentReminderScreen> {
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var _selectedTimes = <TimeOfDay>[];

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _loadSavedReminders();
  }

  void _loadSavedReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTimes = prefs.getStringList('selectedTimes');
    if (savedTimes != null) {
      setState(() {
        _selectedTimes = savedTimes
            .map((timeString) =>
                TimeOfDay.fromDateTime(DateTime.parse(timeString)))
            .toList();
      });
    }
  }

  Future<void> _scheduleNotification(TimeOfDay selectedTime) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    var now = DateTime.now();
    var scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Appointment Reminder',
      'Remember your appointment!',
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  void _toggleNotification(TimeOfDay time) async {
    setState(() {
      if (_selectedTimes.contains(time)) {
        _selectedTimes.remove(time);
      } else {
        _selectedTimes.add(time);
      }
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'selectedTimes',
      _selectedTimes.map((t) => t.format(context)).toList(),
    );
  }

  Future<void> _showTimePickerDialog(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTimes.add(pickedTime);
      });

      await _scheduleNotification(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          // alignment: Alignment.topRight,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: TextView(text: "Appointment Reminder Screen"),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("4cb4d5"),
              hexStringToColor("52afff"),
              hexStringToColor("3282d4"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 150,),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: logoWidget("assets/images/logo2.png"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Set Appointment Reminder',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        _showTimePickerDialog(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_selectedTimes.length} ${_selectedTimes.length == 1 ? 'time' : 'times'} selected',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Selected Times',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _selectedTimes.length,
                        itemBuilder: (context, index) {
                          final time = _selectedTimes[index];
                          return ListTile(
                            title: Text(
                              time.format(context),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _toggleNotification(time);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget logoWidget(String imagePath) {
    return Image.asset(
      imagePath,
      fit: BoxFit.contain,
    );
  }

  Color hexStringToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
