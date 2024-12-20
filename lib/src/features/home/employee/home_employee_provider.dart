
import 'package:barbershop_app/src/core/fp/either.dart';
import 'package:barbershop_app/src/core/providers/aplication_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_employee_provider.g.dart';

@riverpod
Future<int> getTotalSchedulesToday(GetTotalSchedulesTodayRef ref, int userId) async {
  final DateTime(:year, :month, :day) = DateTime.now();
  final filter = (
    date: DateTime(year, month, day, 0, 0, 0),
    userId: userId,
  );

  final scheduleRepository = ref.read(scheduleRepositoryProvider);
  final schedulesResult = await scheduleRepository.findScheduleByDate(filter);

  return switch(schedulesResult){
    Success(value: List(length: final totalSchedules)) => totalSchedules,
    Failure(: final exception) => throw exception,
  };



}