import 'dart:async';

import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/simple_bloc.dart';

import '../api_response.dart';
import 'login_api.dart';

class LoginBloc extends SimpleBloc<bool> {


  Future<ApiResponse<Usuario>> login(String login, String senha) async {

    add(true);

    ApiResponse response = await LoginApi.login(login, senha);

    add(false);

    return response;
  }

}