import 'package:carros/pages/api_response.dart';
import 'file:///C:/Users/Adriano/AndroidStudioProjects/carros/lib/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  bool _showProgress = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Digite o login",
              controller: _tLogin,
              validator: _validateLogin,
              inputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              "Senha",
              "Digite a senha",
              password: true,
              controller: _tSenha,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
              inputAction: TextInputAction.done,
              focusNode: _focusSenha,
            ),
            SizedBox(
              height: 20,
            ),
            AppButton(
              "Login",
              onPressed: _onClickLogin,
              showprogress: _showProgress,
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {

    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _showProgress = true;
    });

    String login = _tLogin.text;
    String senha = _tSenha.text;

    ApiResponse response = await LoginApi.login(login, senha);
    if(response.ok) {

      Usuario user = response.result;
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }
    setState(() {
      _showProgress = false;
    });

  }

  String _validateLogin(text) {
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String _validateSenha(text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 3) {
      return "A senha precisa ter pelo menos 3 números";
    }
    return null;
  }
}
