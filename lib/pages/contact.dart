import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orangeAccent,
        child: Center(
          child: Text(
            "This is Contact Page",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
