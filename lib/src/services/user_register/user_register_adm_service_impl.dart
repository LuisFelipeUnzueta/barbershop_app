import 'package:barbershop_app/src/core/exceptions/service_exception.dart';
import 'package:barbershop_app/src/core/fp/either.dart';
import 'package:barbershop_app/src/core/fp/nil.dart';
import 'package:barbershop_app/src/repositories/user/user_repository.dart';
import 'package:barbershop_app/src/services/user_register/user_register_adm_service.dart';
import 'package:barbershop_app/src/services/users_login/user_login_service.dart';

class UserRegisterAdmServiceImpl implements UserRegisterAdmService {
  final UserRepository userRepository;
  final UserLoginService userLoginService;

  UserRegisterAdmServiceImpl({
    required this.userRepository,
    required this.userLoginService,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) userData) async {
    final registerResult = await userRepository.registerAdmin(userData);

    switch (registerResult) {
      case Success():
        return userLoginService.execute(userData.email, userData.password);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
