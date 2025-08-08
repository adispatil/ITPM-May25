import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_notification_demo/auth_page.dart';
import 'package:local_notification_demo/service/auth_service.dart';
import 'package:local_notification_demo/service/firebase_message_service.dart';
import 'package:local_notification_demo/service/notification_service.dart';
import 'package:local_notification_demo/widgets/custom_card.dart';
import 'package:local_notification_demo/widgets/header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  NotificationService _notificationService = NotificationService();
  AuthService _authService = AuthService();

  DateTime? date;
  TimeOfDay? time;

  @override
  void initState() {
    super.initState();

    initializeNotification();

    FirebaseMessageService().subscribeToTopic("");
  }

  initializeNotification() {
    _notificationService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await _authService.logOutUser();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AuthPage()),
                      (route) => false,
                );
              } catch(ex) {
                // SHOW snackbar
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(),
            Text(
              "Notification types",
              style: GoogleFonts.poppins(fontSize: 20),
            ),
            SizedBox(height: 10.0),

            CustomCard(
              title: "Instant Notification",
              description: "Send a notification that appears immediately",
              onClick: () {
                print("clicked");
                showNotificationInputDialog(isScheduled: false);
              },
              iconData: Icons.notifications,
              iconColor: Colors.purple,
            ),
            SizedBox(height: 16.0),
            CustomCard(
              title: "Scheduled Notification",
              description: "Send a notification that appears after given time",
              onClick: () {
                showNotificationInputDialog(isScheduled: true);
              },
              iconData: Icons.timer,
              iconColor: Colors.blue,
            ),
            SizedBox(height: 16.0),
            CustomCard(
              title: "Clear Notification",
              description: "Clear notifications of the app",
              onClick: () {
                _notificationService.clearAllNotifications();
              },
              iconData: Icons.delete_outline_rounded,
              iconColor: Colors.blueAccent,
            ),

            SizedBox(height: 16.0),
            CustomCard(
              title: "Delete Token",
              description: "",
              onClick: () {
                FirebaseMessageService().deleteToken();
              },
              iconData: Icons.delete_outline_rounded,
              iconColor: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }

  Future showNotificationInputDialog({required bool isScheduled}) {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Send Notification"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Notification Title",
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _descriptionController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Notification Description",
                    ),
                  ),
                  SizedBox(height: 20.0),
                  if (isScheduled)
                    ElevatedButton.icon(
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 2)),
                        );

                        if (picked != null) {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(picked),
                          );

                          if (pickedTime != null) {
                            setState(() {
                              date = picked;
                              time = pickedTime;
                            });

                            print(date);
                            print(time);
                          }
                        }
                      },
                      label: Text("Select Date and Time"),
                      icon: Icon(Icons.timer_outlined),
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  if (isScheduled) {
                    _notificationService.sendScheduledNotification(
                      title: _titleController.text,
                      body: _descriptionController.text,
                      dateTime: DateTime(
                        date!.year,
                        date!.month,
                        date!.day,
                        time!.hour,
                        time!.minute,
                      ),
                    );
                  } else {
                    _notificationService.sendInstantNotification(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );
                  }

                  _titleController.text = "";
                  _descriptionController.text = "";
                },
                child: Text("Send Notification"),
              ),
            ],
          ),
    );
  }
}
