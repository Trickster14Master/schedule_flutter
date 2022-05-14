import 'package:flutter/material.dart';
import 'package:flutter_/style.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import '../provider/event_provider.dart';

class Task_Sraristics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user_app = context.watch<User_Provider>();
    return Scaffold(
        backgroundColor: s.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: s.appBarColor,
          title: AutoSizeText("Общая информация",
              maxLines: 1, style: TextStyle(color: Colors.white)),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Column(children: [
                    Icon(
                      Icons.assignment_ind,
                      color: s.buttonColor,
                      size: 150,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Text("id пользователя: ",
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Text(user_app.id.toString()),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: AutoSizeText("имя пользователя:",
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Text(user_app.name),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: AutoSizeText("mail пользователя:",
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Text(user_app.mail),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: AutoSizeText("пароль пользователя:",
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Text(user_app.password),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: AutoSizeText("token пользователя:",
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Text(user_app.token),
                          ],
                        )),
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
