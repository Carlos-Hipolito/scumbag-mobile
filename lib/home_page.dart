import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actionsIconTheme: const IconThemeData(size: 40),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
        ],
        title: Image.asset('assets/navalha_logo.png', fit: BoxFit.cover),
        centerTitle: false,
        titleSpacing: 25,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: const DecorationImage(
                          image: AssetImage('assets/card_fidelidade.png'),
                          fit: BoxFit.cover),
                      border: Border.all(
                          color: Colors.black,
                          width: 0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(40)),
                  width: screenWidth * 0.90,
                  height: screenHeight * 0.20,
                  child: Column(
                    children: [
                      Text('Scumbag', style: TextStyle(color: Colors.white)),
                      Container(
                        width: 50,
                        height: 50,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              const Text('Home'),
              FloatingActionButton(
                onPressed: () {
                  logout();
                },
                child: const Text('logout'),
              )
            ],
          ),
        ),
      ),
    );
  }

  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('access_token', '');
    Navigator.of(context).pushNamed('/login');
  }
}
