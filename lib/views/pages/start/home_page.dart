import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reserva_pra_mim/views/widgets/nav_bar.dart';
import '../../../modelviews/HomeViewModel.dart';
import '../../../modelviews/firebase/authentication.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/drawerModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel = HomeViewModel();
  bool isAdmin = false;
  int _selectedIndex = 1;
  String userName = "";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      final currentUser = FirebaseAuth.instance.currentUser;
      userName = currentUser?.displayName ?? ""; // Nome do usuário
      userEmail = currentUser?.email ?? ""; // Email do usuário

      Autenticacao().isUserAdmin(FirebaseAuth.instance.currentUser!.uid).then((
          value) {
        setState(() {
          isAdmin = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(isAdmin, userName, userEmail),
      appBar: const CustomAppBar()
      ,
      body: viewModel.buildPage(_selectedIndex),
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

