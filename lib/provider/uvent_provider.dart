import 'package:flutter/cupertino.dart';
import 'package:flutter_/event.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _event = [];

  List<Event> get events => _event;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _event;

  void addEvent(Event event) {
    _event.add(event);
    notifyListeners();
  }
}
