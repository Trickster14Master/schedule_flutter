import 'package:flutter/material.dart';
import 'package:flutter_/style.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../provider/event_provider.dart';
import '../working_database/working_database.dart';

class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _Registration();
}

class _Registration extends State<Registration> {
  List<User>? posts;
  var isLoaded = false;

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mailController = TextEditingController();

  final _nameFocus = FocusNode();
  final _passwordControllerFocus = FocusNode();
  final _passwordControllerFocus2 = FocusNode();

  void _fildFocusChang(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  getData() async {
    posts = await createUser(
        context, _nameController, _mailController, _passwordController);
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
        await getData();
        User user = User(
            id: posts![0].id,
            name: posts![0].name,
            mail: posts![0].mail,
            password: posts![0].password,
            token: posts![0].token);
        Navigator.pushNamed(context, linc);
        final user_app = Provider.of<User_Provider>(context, listen: false);
        user_app.addUser(user);
      },
      child: Text("${text}", style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: s.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: s.appBarColor,
        title: Text("Регистрация", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
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
                        TextFormField(
                          focusNode: _nameFocus,
                          autofocus: true,
                          onFieldSubmitted: (_) {
                            _fildFocusChang(
                                context, _nameFocus, _passwordControllerFocus);
                          },
                          controller: _nameController,
                          decoration:
                              InputDecoration(labelText: "Имя пользователя"),
                        ),
                        TextFormField(
                          focusNode: _passwordControllerFocus,
                          onFieldSubmitted: (_) {
                            _fildFocusChang(context, _passwordControllerFocus,
                                _passwordControllerFocus2);
                          },
                          controller: _mailController,
                          decoration: InputDecoration(labelText: "Почта"),
                        ),
                        TextFormField(
                          focusNode: _passwordControllerFocus2,
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: "Пароль"),
                        ),
                      ]),
                    ),
                    Container(
                      child: Column(children: [
                        button("Зарегистрироваться", "/home_page_schedule"),
                        SizedBox(
                          height: 10,
                        ),
                        button("Войти в аккаунт", "/entrance")
                      ]),
                    ),
                  ]))),
    );
  }
}
