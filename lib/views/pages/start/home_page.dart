import 'package:flutter/material.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: defaultpd * 2, vertical: defaultpd),
        child: Column(children: [Container(), Container(), Container()]),
      ),
    );
  }
}
