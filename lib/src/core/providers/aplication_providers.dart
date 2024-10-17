import 'package:barbershop_app/src/core/restClient/rest_client.dart';
import 'package:barbershop_app/src/repositories/user/user_repository.dart';
import 'package:barbershop_app/src/repositories/user/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'aplication_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => restClient(ref);

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl(restClient: ref.read(restClientProvider));