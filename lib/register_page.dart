import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerformkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            30.0,
            0.0,
            30.0,
            60.0,
          ),
          child: Column(
            children: [
              SizedBox(
                width: 250,
                height: 250,
                child: Image.asset('assets/scumbag_logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2.0, 20.0, 2.0, 5.0),
                        child: CustomTextFieldRegister(
                          validator: (text) => text == null || text.isEmpty
                              ? 'Você deve preencher um nome'
                              : null,
                          hintText: 'Nome',
                          obscureText: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 5.0),
                        child: CustomTextFieldRegister(
                          validator: (text) => text == null || text.isEmpty
                              ? 'Você deve preencher um nome'
                              : null,
                          hintText: 'Sobrenome',
                          obscureText: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 5.0),
                        child: CustomTextFieldRegister(
                          validator: (text) => text == null || text.isEmpty
                              ? 'Você deve preencher um nome'
                              : null,
                          hintText: 'Email',
                          obscureText: false,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 5.0),
                        child: CustomTextFieldRegister(
                          hintText: 'Senha',
                          obscureText: true,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 5.0),
                        child: CustomTextFieldRegister(
                          hintText: 'Confirmar Senha',
                          obscureText: true,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 20.0),
                        child: CustomTextFieldRegister(
                          hintText: 'Telefone',
                          obscureText: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                      minimumSize: const Size(200, 53),
                      backgroundColor: const Color.fromRGBO(238, 7, 15, 1.0),
                      textStyle: const TextStyle(fontSize: 30.0)),
                  onPressed: () {
                    registerformkey.currentState?.validate();
                  },
                  child: const Text('Cadastrar'),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  child: const Text(
                    'Voltar',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        decoration: TextDecoration.underline),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldRegister extends StatelessWidget {
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final String hintText;
  final bool obscureText;
  const CustomTextFieldRegister(
      {super.key,
      required this.hintText,
      this.validator,
      this.onSaved,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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

class RegisterModel {
  final String name;
  final String surname;
  final String email;
  final String password;
  final int phone;

  RegisterModel(
      {this.name = '',
      this.surname = '',
      this.email = '',
      this.password = '',
      this.phone = 0});

  RegisterModel copyWith({
    String? name,
    String? surname,
    String? email,
    String? password,
    int? phone,
  }) {
    return RegisterModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
    );
  }
}
