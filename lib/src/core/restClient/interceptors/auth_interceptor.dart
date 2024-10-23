
import 'package:barbershop_app/src/core/constants/local_storage_keys.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest (RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = 'Authorizadion';
    headers.remove(authHeaderKey);

    if(extra case {'DIO_AUTH_KEY' : true}){
      final sp = await SharedPreferences.getInstance();
      headers.addAll({
        authHeaderKey: 'Bearer ${sp.getString(LocalStorageKeys.accessToken)}'
      });
    }
    handler.next(options);


  }
}