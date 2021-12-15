import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'model/long_term_care_item_order.dart';
import 'redux/cart_reducer.dart';

import 'pages/home.dart';
import 'about.dart';
import 'pages/long_term_care_plan.dart';
import 'long_term_care_item_edit.dart';
import 'model/long_term_care_item.dart';

class LongTermCareApp extends StatelessWidget {
  final Store<List<LongTermCareItemOrder>> store;

  const LongTermCareApp({Key? key, required this.store}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          onGenerateTitle: (context) {
            return AppLocalizations.of(context)!.app_title;
          },
          localizationsDelegates: const [...AppLocalizations.localizationsDelegates],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/': (BuildContext context) => HomePage(),
            '/long_term_care_plan': (BuildContext context) => LongTermCarePlanPage(store: store),
            '/about': (BuildContext context) => new AboutPage()
          },
        ));
  }
}
