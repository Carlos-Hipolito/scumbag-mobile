import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    verifyUser().then((hasToken) => hasToken
        ? Navigator.of(context).pushNamed('/home')
        : Navigator.of(context).pushNamed('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
            width: 300,
            height: 300,
            child: Image.asset('assets/scumbag_logo.png')),
      ),
    );
  }
}

Future<bool> verifyUser() async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  String? accessToken = _sharedPreferences.getString('access_token');
  if (accessToken == null || accessToken.isEmpty) {
    return false;
  }
  return true;
  ;
}
