import 'package:barbershop_app/src/core/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/ui/helpers/messages.dart';

class ScheduleCalendar extends StatefulWidget {
  final VoidCallback cancelPressed;
  final ValueChanged<DateTime> okPressed;

  const ScheduleCalendar(
      {super.key, required this.cancelPressed, required this.okPressed});

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0xffe6e2e9),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          TableCalendar(
            availableGestures: AvailableGestures.none,
            headerStyle: const HeaderStyle(titleCentered: true),
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2010, 01, 01),
            lastDay: DateTime.now().add(
              const Duration(days: 365 * 10),
            ),
            calendarFormat: CalendarFormat.month,
            locale: 'pt_BR',
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
              });
            },
            calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                    color: ColorsConstants.brown, shape: BoxShape.circle),
                todayDecoration: BoxDecoration(
                    color: ColorsConstants.brown.withOpacity(0.3),
                    shape: BoxShape.circle)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: widget.cancelPressed,
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ColorsConstants.brown),
                  )),
              TextButton(
                  onPressed: () {
                    if (selectedDay == null) {
                      Messages.showError('Por favor selecione um dia!', context);
                      return;
                    } 
                    widget.okPressed(selectedDay!);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorsConstants.brown),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
