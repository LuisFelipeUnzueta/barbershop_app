import 'package:barbershop_app/src/core/exceptions/auth_exception.dart';
import 'package:barbershop_app/src/core/fp/either.dart';
import 'package:barbershop_app/src/core/fp/nil.dart';
import 'package:barbershop_app/src/model/user_model.dart';

import '../../core/exceptions/repository_exception.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();

  Future<Either<RepositoryException, Nil>> registerAdmin(({
    String name,
    String email,
    String password,
  }) userData);
}