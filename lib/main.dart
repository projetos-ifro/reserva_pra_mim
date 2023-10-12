import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reserva_pra_mim/views/pages/start/home_page.dart';
import 'package:reserva_pra_mim/views/pages/start/login_page.dart';

import 'modelviews/firebase/authetication.dart';
import 'modelviews/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(LoginEmaileSenha()); // Registrar a instância LoginEmaileSenha

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/login', page: () => LoginPage()),
      //GetPage(name: '/register', page: () => const RegisterPage()),
      GetPage(name: '/home', page: () => const HomeScreen()),
    ],
    home: LoginPage(),
  ));
}
