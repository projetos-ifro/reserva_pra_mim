import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  bool _dataShow = false;
  bool _soundBox = false;
  bool _tv = false;

  final controlRoom = ControlRoom();
  late Room formRoom;
  _Create_roomState() {
    formRoom = Room(
      isAvailable: true,
      name: '',
      description: '',
      withDatashow: false,
      withWifi: false,
      withTv: false,
      withSoundBox: false,
      roomImage: '',
      pricePerHour: 0.0,
      capacity: 0,
    );
  }

  void _saveSala() async {
    if (_formKey.currentState!.validate()) {
      Room newRoom = Room(
        id: FirebaseFirestore.instance.collection('rooms').doc().id,
        isAvailable: true,
        name: _nomeSalaController.text,
        description: _descricaoController.text,
        withDatashow: _dataShow,
        withWifi: _wifi,
        withTv: _tv,
        withSoundBox: _soundBox,
        roomImage: 'none',
        pricePerHour: price,
        capacity: int.parse(_capacidadeController.text),
      );
      await controlRoom.addRoom(newRoom);
      Get.offNamed('/home');
    }
  }

  double price = 15; // Preço base

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
                    contentPadding: const EdgeInsets.all(12.0),
                    labelText: 'Nome',
                    labelStyle: const TextStyle(color: bgColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: bgColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: bgColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: bgColor),
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
                    contentPadding: const EdgeInsets.all(12.0),
                    labelText: 'Descrição',
                    labelStyle: const TextStyle(color: bgColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: bgColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: bgColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: bgColor),
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
                      contentPadding: const EdgeInsets.all(12.0),
                      labelText: 'Capacidade',
                      labelStyle: const TextStyle(color: bgColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: bgColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: bgColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: bgColor),
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

                    price = controlRoom.setPrice(price, value!, roomWithWifi);
                  },
                ),
                CheckboxListTile(
                  title: const Text('DataShow'),
                  value: _dataShow,
                  onChanged: (bool? value) {
                    setState(() {
                      _dataShow = value ?? false;
                    });

                    price =
                        controlRoom.setPrice(price, value!, roomWithDataShow);
                  },
                ),
                CheckboxListTile(
                  title: const Text('Caixa de Som'),
                  value: _soundBox,
                  onChanged: (bool? value) {
                    setState(() {
                      _soundBox = value ?? false;
                    });

                    price = controlRoom.setPrice(price, value!, roomWithSound);
                  },
                ),
                CheckboxListTile(
                  title: const Text('Tv'),
                  value: _tv,
                  onChanged: (bool? value) {
                    setState(() {
                      _tv = value ?? false;
                    });

                    price = controlRoom.setPrice(price, value!, roomWithTV);
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Preço: R\$ $price,00 / Hr',
                  style: TextStyle(
                      color: bgColor,
                      fontSize: defaultpd * 1.5,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 80,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _saveSala();
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
}
