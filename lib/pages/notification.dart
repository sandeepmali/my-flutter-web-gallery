import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        child: Center(
          child: Text(
            "This is notification Page",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
