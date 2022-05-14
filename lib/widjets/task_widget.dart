import 'package:flutter/material.dart';
import 'package:flutter_/event_data_source.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../provider/uvent_provider.dart';
import '../style.dart';

class TaskWidget extends StatefulWidget {
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return Center(
        child: Text('нет заданий'),
      );
    }

    return SfCalendarTheme(
      data: SfCalendarThemeData(),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        // источник данных
        dataSource: EventDataSource(provider.events),
        initialDisplayDate: provider.selectedDate,
        appointmentBuilder: appointBuildet,
        todayHighlightColor: s.buttonColor,
        // onTap: (details) {
        //   if (details.appointments == null) return;

        //   final event = details.appointments!.first;
        //   Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => EventViewingPage(event: event)));
        // },
      ),
    );
  }

  Widget appointBuildet(
      BuildContext context, CalendarAppointmentDetails details) {
    final event = details.appointments.first;
    return Container(
        width: details.bounds.width,
        height: details.bounds.height,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Text(
            event.titlt,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black),
          ),
        ));
  }
}
