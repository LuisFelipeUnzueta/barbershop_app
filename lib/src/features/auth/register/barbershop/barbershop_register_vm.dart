import 'package:barbershop_app/src/core/fp/either.dart';
import 'package:barbershop_app/src/core/providers/aplication_providers.dart';
import 'package:barbershop_app/src/features/auth/register/barbershop/barbershop_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'barbershop_register_vm.g.dart';

@riverpod
class BarbershopRegisterVm extends _$BarbershopRegisterVm {
  @override
  BarbershopRegisterState build() => BarbershopRegisterState.initial();

  void addOrRemoveOpenDay(String weekday) {
    final openingDays = state.openingDays;

    if(openingDays.contains(weekday)){
      openingDays.remove(weekday);
    } else {
      openingDays.add(weekday);
    }

    state = state.copyWith(openingDays: openingDays);
  }

  void addOrRemoveOpenHours (int hour) {
    final openingHours = state.openingHours;

    if(openingHours.contains(hour)){
      openingHours.remove(hour);
    } else {
      openingHours.add(hour);
    }

    state = state.copyWith(openingHours: openingHours);
  }

  Future<void> register(String name, String email) async {
    final repository = ref.watch(barbershopRepositoryProvider);

    final BarbershopRegisterState(:openingDays, :openingHours) = state;

    final dto =(
      name: name,
      email: email,
      openingDays: openingDays,
      openingHours: openingHours,
    );

    final registerResult = await repository.save(dto);

    switch(registerResult){
      case Success():
      ref.invalidate(getMyBarbershopProvider);
        state = state.copyWith(status: BarbershopRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: BarbershopRegisterStateStatus.error);
    }

  }
  
}