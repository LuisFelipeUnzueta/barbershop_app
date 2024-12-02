import 'package:asyncstate/asyncstate.dart';
import 'package:barbershop_app/src/core/fp/either.dart';
import 'package:barbershop_app/src/core/providers/aplication_providers.dart';
import 'package:barbershop_app/src/features/home/adm/home_adm_state.dart';
import 'package:barbershop_app/src/model/barbershop_model.dart';
import 'package:barbershop_app/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_adm_vm.g.dart';

@riverpod
class HomeAdmVm extends _$HomeAdmVm {
  @override
  Future<HomeAdmState> build() async {
    final repository = ref.read(userRepositoryProvider);
    final BarbershopModel(id: babershopId) =
        await ref.read(getMyBarbershopProvider.future);

    final me = await ref.watch(getMeProvider.future);

    final employeesResult = await repository.getEmployees(babershopId);

    switch (employeesResult) {
      case Success(value: final employeesData):
        final employees = <UserModel>[];
        employees.addAll(employeesData);
        if (me case UserModelAdm(workDays: _?, workHours: _?)) {
          employees.add(me);
        }

        return HomeAdmState(
            status: HomeAdmStateStatus.loaded, employees: employees);
      case Failure():
        return HomeAdmState(status: HomeAdmStateStatus.error, employees: []);
    }
  }

  Future<void> logout() async => ref.read(logoutProvider.future).asyncLoader();
}
