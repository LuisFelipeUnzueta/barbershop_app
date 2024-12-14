import 'package:asyncstate/asyncstate.dart';
import 'package:barbershop_app/src/core/fp/either.dart';
import 'package:barbershop_app/src/core/providers/aplication_providers.dart';
import 'package:barbershop_app/src/features/schedule/schedule_state.dart';
import 'package:barbershop_app/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/barbershop_model.dart';

part 'schedule_vm.g.dart';

@riverpod
class ScheduleVm extends _$ScheduleVm {
  @override
  ScheduleState build() => ScheduleState.initial();

  void hourSelect(int hour) {
    if (hour == state.scheduleHour) {
      state ==
          state.copyWith(
            scheduleHour: () => null,
          );
    } else {
      state = state.copyWith(
        scheduleHour: () => hour,
      );
    }
  }

  void dateSelect(DateTime date) {
    state = state.copyWith(scheduleDate: () => date);
  }

  Future<void> register(
      {required UserModel userModel, required String clientName}) async {
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final ScheduleState(:scheduleDate, :scheduleHour) = state;
    final scheduleRepository = ref.watch(scheduleRepositoryProvider);
    final BarbershopModel(id: barbershopId) =
        await ref.watch(getMyBarbershopProvider.future);

    final dto = (
      barbershopId: barbershopId,
      userId: userModel.id,
      clientName: clientName,
      date: scheduleDate!,
      time: scheduleHour!,
    );

    final scheduleResult = await scheduleRepository.scheduleClient(dto);

    switch(scheduleResult){
      case Success():
        state = state.copyWith(status: ScheduleStateStatus.success);
      case Failure():
       state = state.copyWith(status: ScheduleStateStatus.error);
    }

    asyncLoaderHandler.close();
  }
}
