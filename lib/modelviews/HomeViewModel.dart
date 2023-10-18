import 'package:flutter/material.dart';

import '../views/pagesnavigation/historico.dart';
import '../views/pagesnavigation/inicio.dart';
import '../views/pagesnavigation/progresso.dart';
import 'historico/historico_controller.dart';

class HomeViewModel {
  Widget buildPage(int index) {
    switch (index) {
      case 0:
        return ProgressoPage();
      case 1:
        return InicioPage();
      case 2:
        return HistoricoPage(viewModel: Historico_Controller());
      default:
        return Container();
    }
  }
}
