import 'package:flutter/material.dart';
import 'dart:convert';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("關於"),
      ),
      body: const Center(
        child: Text("這個 App 隨便寫寫，有 Bug 不修，謝謝。"),
      ),
    );
  }
}
