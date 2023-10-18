import 'package:flutter/material.dart';

import '../views/pagesnavigation/historico.dart';
import '../views/pagesnavigation/inicio.dart';
import '../views/pagesnavigation/progresso.dart';

class HomeViewModel {
  Widget buildPage(int index) {
    switch (index) {
      case 0:
        return ProgressoPage();
      case 1:
        return InicioPage();
      case 2:
        return HistoricoPage();
      default:
        return Container();
    }
  }
}
