import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reserva_pra_mim/views/pages/start/home_page.dart';
import 'package:reserva_pra_mim/views/pages/start/login_page.dart';
import 'package:reserva_pra_mim/views/pages/start/logon_page.dart';
import 'modelviews/firebase/authentication.dart';
import 'modelviews/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(LoginEmaileSenha());
  Get.put(RegisterEmailSenha());
  Get.put(Logout());

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/login', page: () => LoginPage()),
      GetPage(name: '/logon', page: () => const LogonPage()),
      GetPage(name: '/home', page: () => const HomeScreen()),
    ],
    home: LoginPage(),
  ));
}
