import 'package:flutter/material.dart';

class Exams extends StatelessWidget {
  const Exams({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Exams"),
          centerTitle: true,
        )
    );
  }
}