// вход
import 'package:flutter/material.dart';
import 'package:flutter_/models/task.dart';
import 'package:flutter_/provider/uvent_provider.dart';
import 'package:flutter_/style.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../provider/event_provider.dart';
import '../working_database/working_database.dart';

class Entrance extends StatefulWidget {
  @override
  State<Entrance> createState() => _Entrance();
}

class _Entrance extends State<Entrance> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  List<User>? posts;
  var isLoaded = false;

  getUser() async {
    posts = await user_authentication(
        context, _nameController, _passwordController);
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  List<Task>? task;
  getTask() async {
    posts = await receiveTask(context, posts![0].token);
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Widget button(text, linc) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: s.buttonColor, minimumSize: Size(250, 70)),
      onPressed: () async {
        await getUser();
        User user = User(
            id: posts![0].id,
            name: posts![0].name,
            mail: posts![0].mail,
            password: posts![0].password,
            token: posts![0].token);
        final user_app = Provider.of<User_Provider>(context, listen: false);
        user_app.addUser(user);
        final event_app = Provider.of<EventProvider>(context, listen: false);

        Navigator.pushNamed(context, linc);
      },
      child: Text("${text}", style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: s.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: s.appBarColor,
          title: Text("Вход", style: TextStyle(color: Colors.white)),
        ),
        body: Center(
            child: Center(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Icon(
                            Icons.watch_later,
                            color: s.buttonColor,
                            size: 150,
                          ),
                        ),
                        Container(
                          child: Column(children: [
                            Container(
                              child: Column(children: [
                                TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                      labelText: "Имя пользователя"),
                                ),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration:
                                      InputDecoration(labelText: "Пароль"),
                                ),
                              ]),
                            ),
                            Container(
                              child: Column(children: [
                                SizedBox(
                                  height: 10,
                                ),
                                button("Войти в аккаунт", "/home_page_schedule")
                              ]),
                            ),
                          ]),
                        ),
                      ],
                    )))));
  }
}
