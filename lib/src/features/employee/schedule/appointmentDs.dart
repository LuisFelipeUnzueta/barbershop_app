import 'package:barbershop_app/src/core/ui/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../model/schedule_model.dart';

class AppointmentDs extends CalendarDataSource {
  final List<ScheduleModel> schedules;

  AppointmentDs({
    required this.schedules,
  });

  @override
  List<dynamic>? get appointments {
    return schedules.map((e) {
      final ScheduleModel(
        date: DateTime(:year, :month, :day),
        :hour,
        :clientName
      ) = e;
      final startTime = DateTime(year, month, day, hour, 0, 0);
      final endTime = DateTime(year, month, day, hour+1, 0, 0);


      return Appointment(
        color: ColorsConstants.brown,
        startTime: startTime,
        endTime: endTime,
        subject: clientName,
        );
    }).toList();
  }

  // [
  //       Appointment(
  //         color: ColorsConstants.brown,
  //         startTime: DateTime.now(),
  //         endTime: DateTime.now().add(
  //           Duration(hours: 1),
  //         ),
  //       ),
  //     ];
}
