import 'package:barbershop_app/src/features/employee/register/employee_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_register_vm.g.dart';

@riverpod
class EmployeeRegisterVm extends _$EmployeeRegisterVm{
  @override
  EmployeeRegisterState build() => EmployeeRegisterState.initial();

  void setRegisterAdm(bool isRegisterAdm) {
    state = state.copyWith(registerAdm: isRegisterAdm);
  }

  void addOrRemoveWorkDays(String weekDay) {
    final workDays = state.workDays;
    if(workDays.contains(weekDay)){
      workDays.remove(weekDay);
    } else {
      workDays.add(weekDay);
    }

    state = state.copyWith(workDays: workDays);
  }

  void addOrRemoveWorkHours(int hour) {
    final workHours = state.workHours;
    if(workHours.contains(hour)){
      workHours.remove(hour);
    } else {
      workHours.add(hour);
    }

    state = state.copyWith(workHours: workHours);
  }
}