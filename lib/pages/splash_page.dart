import 'package:carros/pages/favoritos/db_helper.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

import 'carro/home_page.dart';
import 'login/usuario.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // Inicializa o banco de dados
    Future futureDB = DatabaseHelper.getInstance().db;

    Future futureDelay = Future.delayed(Duration(seconds: 3));

    // Verifica se o usuário está logado
    Future<Usuario> futureUser = Usuario.get();

    Future.wait([futureDB, futureDelay, futureUser]).then((List values) {
      Usuario user = values[2];

      if (user != null) {
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
