import 'package:barbershop_app/src/core/exceptions/repository_exception.dart';
import 'package:barbershop_app/src/model/barbershop_model.dart';
import 'package:barbershop_app/src/model/user_model.dart';

import '../../core/fp/either.dart';

abstract interface class BarbershopRepository {

  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(UserModel userModel); 
}