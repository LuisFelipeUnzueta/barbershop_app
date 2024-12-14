import 'package:barbershop_app/src/core/exceptions/repository_exception.dart';
import 'package:barbershop_app/src/core/fp/either.dart';
import 'package:barbershop_app/src/core/providers/aplication_providers.dart';
import 'package:barbershop_app/src/model/schedule_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_schedule_vm.g.dart';

@riverpod
class EmployeeScheduleVm extends _$EmployeeScheduleVm {
  Future<Either<RepositoryException, List<ScheduleModel>>> _getSchedule(
      int userId, DateTime date) {
    final repository = ref.read(scheduleRepositoryProvider);
    return repository.findScheduleByDate((userId: userId, date: date));
  }

  @override
  Future<List<ScheduleModel>> build(int userId, DateTime date) async {
    var scheduleListResult = await _getSchedule(userId, date);

    return switch (scheduleListResult) {
      Success(value: final schedules) => schedules,
      Failure(:final exception) => throw Exception(exception),
    };
  }

  Future<void> changeDate(int userId, DateTime date) async {
    var scheduleListResult = await _getSchedule(userId, date);

    state = switch (scheduleListResult) {
      Success(value: final schedules) => AsyncData(schedules),
      Failure(:final exception) => AsyncError(Exception(exception), StackTrace.current),
    };
  }
}
