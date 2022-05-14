import 'package:flutter/material.dart';
import 'package:flutter_/event.dart';
import 'package:flutter_/style.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../provider/event_provider.dart';
import '../provider/uvent_provider.dart';
import '../uils.dart';
import '../working_database/working_database.dart';

class task_by_date extends StatefulWidget {
  final Event? event;

  const task_by_date({Key? key, this.event}) : super(key: key);

  @override
  State<task_by_date> createState() => _task_by_dateState();
}

class _task_by_dateState extends State<task_by_date> {
  late DateTime fromDate;
  late DateTime toDate;
  final titleController = TextEditingController();
  final description = TextEditingController();
  List<Task>? received_task;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      // создаём стартовые даты
      fromDate = DateTime.now();
      // стартовая дато но + два часа
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  // отчистка поля
  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // переменнаю внутри которой хронится экземпляр расписания

    return Scaffold(
        backgroundColor: s.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: s.appBarColor,
          title: AutoSizeText("Задача к определённой дате",
              maxLines: 1, style: TextStyle(color: Colors.white)),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.notes_sharp,
                        color: s.buttonColor,
                        size: 120,
                      ),
                      new Flexible(
                        child: new TextFormField(
                          validator: (title) => title != null && title.isEmpty
                              ? "нет названия"
                              : null,
                          controller: titleController,
                          decoration:
                              InputDecoration(labelText: "Название задачи"),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Flexible(
                    child: new TextFormField(
                      validator: (title) => title != null && title.isEmpty
                          ? "нет названия"
                          : null,
                      controller: description,
                      decoration: InputDecoration(labelText: "описание"),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //с какой даты и времени начать
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'From',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              child: Expanded(
                                  child: buildDropdField(
                                      text: Utils.toDate(fromDate),
                                      onClicked: () =>
                                          pickFromDateTime(pickDate: true))),
                            ),
                            Container(
                              child: Expanded(
                                  child: buildDropdField(
                                      text: Utils.toTime(fromDate),
                                      onClicked: () =>
                                          pickFromDateTime(pickDate: false))),
                            )
                          ],
                        )
                      ]),
                ),
                SizedBox(height: 20),
                //до какой даты и времени будет продолжаться задача
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'To',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              child: Expanded(
                                  child: buildDropdField(
                                      text: Utils.toDate(toDate),
                                      onClicked: () =>
                                          pickToDateTime(pickDate: true))),
                            ),
                            Container(
                                child: Expanded(
                              child: buildDropdField(
                                  text: Utils.toTime(toDate),
                                  onClicked: () {
                                    pickToDateTime(pickDate: false);
                                  }),
                            ))
                          ],
                        )
                      ]),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: s.buttonColor, minimumSize: Size(500, 70)),
                  onPressed: () {
                    getData();
                    //sayeForm();
                    var user_app =
                        Provider.of<User_Provider>(context, listen: false);
                    print(user_app.id);
                    createTasc(context, user_app.id, titleController,
                        description, fromDate, toDate, 1);
                  },
                  child:
                      Text("Сохранить", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ));
  }

  //выбор стартовой даты
  Future pickFromDateTime({required bool pickDate}) async {
    //переменная в которой хранится дата
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;
    //условие каректного выбора даты
    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(
      () => fromDate = date,
    );
  }

  getData() async {
    final user_app = context.read<User_Provider>();
    received_task = await receiveTask(context, user_app.token);
    if (received_task != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  //выбор конечной даты
  Future pickToDateTime({required bool pickDate}) async {
    //переменная в которой хранится дата
    final date = await pickDateTime(toDate,
        pickDate: pickDate,
        // делаем так что бы не льзя было выбрать дату до начальной даты
        firstDate: pickDate ? fromDate : null);
    if (date == null) return;
    setState(
      () => toDate = date,
    );
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    //выбор даты
    if (pickDate) {
      //выбираем дату и врямя
      final date = await showDatePicker(
        context: context,
        //дата которая будет выбронна ипо умолчанию
        initialDate: initialDate,
        //пределы календаря
        firstDate: firstDate ?? DateTime(2000, 8),
        lastDate: DateTime(2122),
      );
      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      // обьединяем дату и время
      return date.add(time);
    }
  }

  Widget buildDropdField(
      {required String text, required VoidCallback onClicked}) {
    return ListTile(
      //focusColor: Colors.amber,
      title: Text(text),
      trailing: Icon(Icons.arrow_drop_down_sharp),
      onTap: onClicked,
    );
  }

  Future sayeForm() async {
    final event = Event(
        titlt: titleController.text,
        description: 'r',
        from: fromDate,
        to: toDate,
        Status: 1);
    final provide = Provider.of<EventProvider>(context, listen: false);
    provide.addEvent(event);
    Navigator.of(context).pop();
  }

  // Widget tasks_from_server(BuildContext context) {
  //   return ListView.builder(
  //     itemCount: received_task?.length,

  //     itemBuilder: (context, index) {
  //       return  Provider.of<EventProvider>(context, listen: );
  //     },
  //   );
  // }

}
