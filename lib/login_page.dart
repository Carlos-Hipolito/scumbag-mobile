import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    var login = LoginModel();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
        padding: const EdgeInsets.fromLTRB(
          30.0,
          0.0,
          30.0,
          60.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                width: 300,
                height: 300,
                child: Image.asset('assets/scumbag_logo.png')),
            Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 10.0),
                      child: CustomTextFieldLogin(
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          hintText: 'Email',
                          onSaved: (text) =>
                              login = login.copyWith(email: text),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Você deve passar um email';
                            }
                          })),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 0.0),
                    child: CustomTextFieldLogin(
                      obscureText: true,
                      hintText: 'Senha',
                      onSaved: (text) => login = login.copyWith(password: text),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Você deve passar uma senha';
                        }
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Esqueceu a senha?',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          )))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 400,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                          onPressed: () {
                            if (formkey.currentState?.validate() == true) {
                              formkey.currentState?.save();
                              loginUser(login);
                            }
                          },
                          style: FilledButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(18, 102, 213, 1.0),
                              minimumSize: const Size(200, 53),
                              textStyle: const TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.w700)),
                          child: const Text('Entrar')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                        child: const Text('Cadastrar'),
                        style: FilledButton.styleFrom(
                            minimumSize: const Size(200, 53),
                            backgroundColor: Color.fromRGBO(238, 7, 15, 1.0),
                            textStyle: const TextStyle(fontSize: 30.0)),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/register');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                    onPressed: () {},
                    style:
                        FilledButton.styleFrom(backgroundColor: Colors.black),
                    child: Image.asset('assets/facebook_logo.png')),
                FilledButton(
                    onPressed: () {},
                    style:
                        FilledButton.styleFrom(backgroundColor: Colors.black),
                    child: Image.asset('assets/google_logo.png')),
              ],
            )
          ],
        ),
      )),
    );
  }

  loginUser(LoginModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('http://localhost:3000/api/auth');
    var response = await http
        .post(url, body: {'email': user.email, 'password': user.password});

    if (response.statusCode == 201) {
      String accessToken = json.decode(response.body)['token'];
      sharedPreferences.setString('access_token', 'Bearer $accessToken');
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed('/');
    }
    if (response.statusCode == 403) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario ou senha incorretos!'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text('Verifique sua conexão de internet e tente novamente')),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}

class CustomTextFieldLogin extends StatelessWidget {
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final TextInputType? keyboardType;
  final String hintText;
  final bool obscureText;
  const CustomTextFieldLogin({
    super.key,
    required this.hintText,
    this.validator,
    this.onSaved,
    required this.obscureText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      onSaved: onSaved,
      style: const TextStyle(decorationColor: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(5.0)),
        hintText: hintText,
        hintStyle:
            TextStyle(color: Colors.grey[400], fontStyle: FontStyle.italic),
      ),
    );
  }
}

class LoginModel {
  final String email;
  final String password;

  LoginModel({this.email = '', this.password = ''});

  LoginModel copyWith({
    String? email,
    String? password,
  }) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
