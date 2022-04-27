import 'dart:ffi';

import 'package:eventor_two/constants.dart';
import 'package:flutter/material.dart';
import 'components/google_map_screen.dart';

class Eventor extends StatefulWidget {
  const Eventor({Key? key}) : super(key: key);

  @override
  State<Eventor> createState() => _EventorState();
}

class _EventorState extends State<Eventor> {
  int _selectedIndex = 0;
  final Widget _myGoogleMap = const GoogleMapScreen();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
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
              Icons.add_location_rounded,
              color: kPrimaryColor,
            ),
            activeIcon: Icon(
              Icons.add_location_rounded,
              color: Colors.green,
            ),
            label: 'Маркер',
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

  Widget getBody() {
    if (_selectedIndex == 0) {
      return _myGoogleMap;
    } else {
      return _myGoogleMap;
    }
  }
}
