import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reserva_pra_mim/modelviews/reserve/reserve_controller.dart';
import 'package:reserva_pra_mim/modelviews/room/room_cotroller.dart';
import 'package:reserva_pra_mim/views/pages/salas/detail_reserved_room.dart';
import 'package:reserva_pra_mim/views/pages/salas/detail_room.dart';
import 'package:reserva_pra_mim/views/pages/start/home_page.dart';
import 'package:reserva_pra_mim/views/pages/start/login_page.dart';
import 'package:reserva_pra_mim/views/pages/start/logon_page.dart';
import 'package:reserva_pra_mim/views/pagesnavigation/historico.dart';
import 'modelviews/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(ControlRoom());
  Get.put(Control_reserve());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/login', page: () => LoginPage()),
      GetPage(name: '/logon', page: () => LogonPage()),
      GetPage(name: '/home', page: () => const HomeScreen()),
      GetPage(name: '/detail', page: () => const Detail_room()),
      GetPage(name: '/history', page: () => const HistoricoPage()),
      GetPage(
          name: '/detailReserved', page: () => const Detail_reserved_room()),
    ],
    home: LoginPage(),
  ));
}
