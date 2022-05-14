// файл из которого всё запускается
import 'package:flutter/material.dart';
import 'package:flutter_/page/task_by_date.dart';
import 'package:flutter_/page/task_statistics.dart';
import 'package:flutter_/provider/event_provider.dart';
import 'package:flutter_/provider/uvent_provider.dart';
import 'package:flutter_/reg/registration.dart';
import 'package:flutter_/style.dart';
import 'package:provider/provider.dart';
import 'reg/entrance.dart';
import 'page/home_page_schedule.dart';
//import 'package:flutter_/pages/registor_form_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => User_Provider(),
        child: ChangeNotifierProvider(
          create: (context) => EventProvider(),
          child: MaterialApp(
            // локализация
            //supportedLocales: l10n.all,
            //theme: ,
            title: 'Расписание ',
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: s.buttonColor,
            ),
            routes: {
              "/home_page_schedule": (context) => home_page_schedule(),
              "/task_by_date": (context) => task_by_date(),
              "/task_statistics": (context) => Task_Sraristics(),
              "/entrance": (context) => Entrance()
            },

            home: Registration(),
          ),
        ),
      );
}
