import 'dart:developer';
import 'dart:html';

import 'package:barbershop_app/src/core/exceptions/auth_exception.dart';
import 'package:barbershop_app/src/core/exceptions/repository_exception.dart';
import 'package:barbershop_app/src/core/fp/either.dart';
import 'package:barbershop_app/src/core/restClient/rest_client.dart';
import 'package:barbershop_app/src/model/user_model.dart';
import 'package:barbershop_app/src/repositories/user/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth
          .post('/auth', data: {'email': email, 'password': password});

      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        var statusCode = e.response!.statusCode;
        if (statusCode == HttpStatus.forbidden) {
          log('Email ou senha inválidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(
        AuthError(
          message: e.message!,
        ),
      );
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário logado', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar o usuário logado'));
    } on ArgumentError catch (e, s) {
      log('Invalid Json', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }
}
