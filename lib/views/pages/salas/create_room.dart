import 'package:flutter/material.dart';
import 'package:reserva_pra_mim/models/room.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';
import 'package:reserva_pra_mim/modelviews/room/room_cotroller.dart';

class Create_room extends StatefulWidget {
  const Create_room({super.key});

  @override
  State<Create_room> createState() => _Create_roomState();
}

class _Create_roomState extends State<Create_room> {
  TextEditingController _textHomeSearch = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeSalaController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _capacidadeController = TextEditingController();
  bool _wifi = false;
  bool _DataShow = false;
  bool _SoundBox = false;
  bool _Tv = false;

  late Room formRoom;
  final controlRoom = ControlRoom();

  @override
  void dispose() {
    _nomeSalaController.dispose();
    _descricaoController.dispose();
    _capacidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: bgColor),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            'Criar uma Sala',
            textAlign: TextAlign.center,
            style: TextStyle(color: bgColor),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultpd),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nomeSalaController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12.0),
                    labelText: 'Nome',
                    labelStyle: TextStyle(color: bgColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: bgColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: bgColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: bgColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12.0),
                    labelText: 'Descrição',
                    labelStyle: TextStyle(color: bgColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: bgColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: bgColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: bgColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 160,
                  child: TextFormField(
                    controller: _capacidadeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12.0),
                      labelText: 'Capacidade',
                      labelStyle: TextStyle(color: bgColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: bgColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: bgColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: bgColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CheckboxListTile(
                  title: const Text('Wifi'),
                  value: _wifi,
                  onChanged: (bool? value) {
                    setState(() {
                      _wifi = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('DataShow'),
                  value: _DataShow,
                  onChanged: (bool? value) {
                    setState(() {
                      _DataShow = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Caixa de Som'),
                  value: _SoundBox,
                  onChanged: (bool? value) {
                    setState(() {
                      _SoundBox = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Tv'),
                  value: _Tv,
                  onChanged: (bool? value) {
                    setState(() {
                      _Tv = value ?? false;
                    });
                  },
                ),
                const SizedBox(
                  height: 80,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controlRoom.addRoom(formRoom);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: bgColor,
                      ),
                      child: const Center(
                        child: Text(
                          'Adicionar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveSala() async {
    if (_formKey.currentState!.validate()) {
      Sala novaSala = Sala(
        id: FirebaseFirestore.instance.collection('salas').doc().id,
        nome: _nomeController.text,
        capacidade: int.parse(_capacidadeController.text),
        custoPorHora: double.parse(_custoPorHoraController.text),
        recursos: _recursosSelecionados,
      );
      await salaController.addSala(novaSala);
      Get.offNamed('/salas');
    }
  }
}
