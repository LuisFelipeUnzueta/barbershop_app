import 'package:barbershop_app/src/core/exceptions/service_exception.dart';
import 'package:barbershop_app/src/core/fp/either.dart';

import '../../core/fp/nil.dart';

abstract interface class UserLoginService {
  Future<Either<ServiceException,Nil>> execute(String email, String password);
}