import 'package:flutter/material.dart';
import 'package:flutter_/provider/uvent_provider.dart';
import 'package:flutter_/widjets/task_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../event_data_source.dart';
import '../style.dart';
import 'package:provider/provider.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //переносим значение из провайдера
    final event = Provider.of<EventProvider>(context).events;
    return SfCalendar(
      dataSource: EventDataSource(event),
      view: CalendarView.month,
      cellBorderColor: s.buttonColor,
      backgroundColor: s.backgroundColor,
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);
        provider.setDate(details.date!);
        showModalBottomSheet(
            context: context, builder: (context) => TaskWidget());
      },
    );
  }
}
