import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations!.app_title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Crystal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(localizations.app_drawer_home),
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: Text(localizations.app_drawer_long_trem_care_plan),
              onTap: () {
                Navigator.pushNamed(context, "/long_term_care_plan");
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: Text(localizations.app_drawer_help),
              onTap: () {
                Navigator.pushNamed(context, "/about");
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text("這個 App 隨便寫寫，有 Bug 不修，謝謝。"),
      ),
    );
  }
}
