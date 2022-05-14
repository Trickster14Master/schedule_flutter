import 'package:flutter/material.dart';
import 'package:flutter_/style.dart';
import 'package:flutter_/widjets/button.dart';
import 'package:flutter_/widjets/calendar_widget.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../provider/event_provider.dart';
import '../working_database/working_database.dart';

class home_page_schedule extends StatefulWidget {
  @override
  State<home_page_schedule> createState() => _home_page_scheduleState();
}

class _home_page_scheduleState extends State<home_page_schedule> {
  get width => null;
  get height => null;

  List<Task>? task;
  var isLoaded = false;
  getTask(user_app) async {
    task = await receiveTask(context, user_app.token);
    if (task != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Widget button(text, linc) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: s.buttonColor, minimumSize: Size(300, 100)),
      onPressed: () {
        Navigator.pushNamed(context, linc);
      },
      child: Text("${text}", style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user_app = context.watch<User_Provider>();

    return Scaffold(
        backgroundColor: s.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: s.appBarColor,
          title:
              Text("Главная страница", style: TextStyle(color: Colors.white)),
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'lib/assets/images/bb.jpg',
                        ),
                        fit: BoxFit.fill)),
                child: SizedBox(
                  width: 500,
                  child: ListView(
                    children: [
                      Container(
                        child: Column(children: [
                          button_widjet(
                            text: "Сделать задачу",
                            linc: "/task_by_date",
                            height: 70,
                            width: 500,
                          ),
                          SizedBox(height: 20),
                          SizedBox(height: 20),
                          button_widjet(
                            text: "Общая информация",
                            linc: "/task_statistics",
                            height: 70,
                            width: 500,
                          ),
                          SizedBox(height: 20),
                        ]),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: CalendarWidget(),
                      )
                    ],
                  ),
                ))));
  }
}
