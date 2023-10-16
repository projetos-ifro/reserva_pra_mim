import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import 'package:reserva_pra_mim/models/room.dart';

class ControlRoom extends GetxController {
  final firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  @override
  var availableRooms = <Room>[].obs;

  void onInit() {
    super.onInit();
  }

  Future<void> addRoom(Room room) async {
    try {
      isLoading(true);
      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(room.id)
          .set(room.toMap());
    } catch (e) {
      print("Erro ao tentar adicionar a sala: $e");
    } finally {
      isLoading(false);
      Get.back();
    }
  }
}