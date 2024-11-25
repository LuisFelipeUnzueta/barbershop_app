import 'package:asyncstate/asyncstate.dart';
import 'package:barbershop_app/src/core/exceptions/service_exception.dart';
import 'package:barbershop_app/src/core/fp/either.dart';
import 'package:barbershop_app/src/core/providers/aplication_providers.dart';
import 'package:barbershop_app/src/features/auth/login/login_state.dart';
import 'package:barbershop_app/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.inital();

  Future<void> login(String email, String password) async {
    final loaderHandle = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.execute(email, password);

    switch (result) {
      case Success():
        //indalidar os caches para n logar com o usuário errado
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyBarbershopProvider);

        final userModel = await ref.read(getMeProvider.future);
        switch (userModel) {
          case UserModelAdm():
            state = state.copyWith(status: LoginStateStatus.admLogin);
            break;
          case UserModelEmployee():
            state = state.copyWith(status: LoginStateStatus.employeeLogin);
            break;
        }

      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
            status: LoginStateStatus.error, errorMessage: () => message);
    }
    loaderHandle.close();
  }
}
