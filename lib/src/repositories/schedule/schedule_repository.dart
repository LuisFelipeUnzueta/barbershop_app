import 'package:barbershop_app/src/core/exceptions/repository_exception.dart';
import 'package:barbershop_app/src/core/fp/either.dart';
import 'package:barbershop_app/src/core/fp/nil.dart';
import 'package:barbershop_app/src/model/schedule_model.dart';

abstract interface class ScheduleRepository {
  Future<Either<RepositoryException,Nil>> scheduleClient(({
    int barbershopId,
    int userId,
    String clientName,
    DateTime date,
    int time,
  } ) scheduleData);

  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(({
    DateTime date,
    int userId,
  }) filter);
}