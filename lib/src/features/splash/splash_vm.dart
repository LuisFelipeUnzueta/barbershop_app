import 'package:barbershop_app/src/core/constants/local_storage_keys.dart';
import 'package:barbershop_app/src/core/providers/aplication_providers.dart';
import 'package:barbershop_app/src/model/user_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_vm.g.dart';

enum SplashState {
  initial,
  login,
  loggedAdm,
  loggedEmployee,
  error,
}

@riverpod
class SplashVm extends _$SplashVm {
  @override
  Future<SplashState> build() async {
    final sp = await SharedPreferences.getInstance();

    if (sp.containsKey(LocalStorageKeys.accessToken)) {
      ref.invalidate(getMeProvider);
      ref.invalidate(getMyBarbershopProvider);

      try {
        final userModel = await ref.watch(getMeProvider.future);
        return switch (userModel) {
          UserModelAdm() => SplashState.loggedAdm,
          UserModelEmployee() => SplashState.loggedEmployee,
        };
      } catch (e) {
        return SplashState.login;
      }
    }
    return SplashState.login;
  }
}
