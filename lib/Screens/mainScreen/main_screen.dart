import 'package:eventor_two/constants.dart';
import 'package:flutter/material.dart';

import '../../data_models/user.dart';
import 'components/google_map_screen.dart';
import 'components/profile_screen.dart';

class Eventor extends StatefulWidget {
  final dynamic httpService;
  late User? user;
  Eventor({Key? key, this.httpService, required this.user}) : super(key: key);

  @override
  State<Eventor> createState() => _EventorState();
}

class _EventorState extends State<Eventor> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: null,
      body: getBody(widget.user),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: kPrimaryColor,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.green,
            ),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
              color: kPrimaryColor,
            ),
            activeIcon: Icon(
              Icons.account_circle_rounded,
              color: Colors.green,
            ),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget getBody(dynamic user) {
    if (_selectedIndex == 0) {
      return GoogleMapScreen(user: user);
    } else if (_selectedIndex == 1) {
      return ProfileScreen(
        user: user,
      );
    } else {
      return GoogleMapScreen(user: user);
    }
  }
}
