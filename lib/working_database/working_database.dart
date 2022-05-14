import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

Future<List<User>?> createUser(
    BuildContext context, name, mail, password) async {
  var r = await http.post(
    Uri.parse("http://217.71.129.139:4800/create_user.php"),
    body: {
      "name": name.text,
      "mail": mail.text,
      "password": password.text,
    },
  );
  return userFromJson(r.body);
}

Future createTasc(BuildContext context, id_user, titlt, description, from_date,
    to_date, status) async {
  return await http.post(
    Uri.parse("http://217.71.129.139:4800/create_tasc.php"),
    body: {
      "id_user": id_user.toString(),
      "titlt": titlt.text,
      "description": description.text,
      "from_date": from_date.toString(),
      "to_date": to_date.toString(),
      "status": status.toString(),
    },
  );
}

Future<List<Task>?> receiveTask(BuildContext context, token) async {
  var client = http.Client();
  var uri = Uri.parse('http://217.71.129.139:4800/all_task.php');
  var response = await client.post(uri, body: {
    "token": token.toString(),
  });
  if (response.statusCode == 200) {
    var json = response.body;
    return taskFromJson(json);
  }
}

Future<List<User>?> user_authentication(
    BuildContext context, name, password) async {
  var r = await http.post(
    Uri.parse("http://217.71.129.139:4800/authentication.php"),
    body: {
      "name": name.text,
      "password": password.text,
    },
  );
  return userFromJson(r.body);
}
