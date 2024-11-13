import 'package:barbershop_app/src/core/fp/either.dart';
import 'package:barbershop_app/src/core/restClient/rest_client.dart';
import 'package:barbershop_app/src/model/user_model.dart';
import 'package:barbershop_app/src/repositories/barbershop/barbershop_repository.dart';
import 'package:barbershop_app/src/repositories/barbershop/barbershop_repository_impl.dart';
import 'package:barbershop_app/src/repositories/user/user_repository.dart';
import 'package:barbershop_app/src/repositories/user/user_repository_impl.dart';
import 'package:barbershop_app/src/services/users_login/user_login_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/barbershop_model.dart';
import '../../services/users_login/user_login_service.dart';

part 'aplication_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => restClient(ref);

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);
  final barbershopRepository = ref.watch(barbershopRepositoryProvider);
  final result = await barbershopRepository.getMyBarbershop(userModel);

  return switch(result) {
    Success(value: final barbershop) => barbershop,
    Failure(:final exception) => throw exception,
  };
}
