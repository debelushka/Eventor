import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Eventor(),
    );
  }
}

class Eventor extends StatefulWidget {
  const Eventor({Key? key}) : super(key: key);

  @override
  State<Eventor> createState() => _EventorState();
}

class _EventorState extends State<Eventor> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Тут должна быть карта',
      style: optionStyle,
    ),
    Text(
      'Сюда сделать добавление маркера',
      style: optionStyle,
    ),
    Text(
      'Тут профиль юзера',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Eventor',
          style: TextStyle(
              color: Colors.amber, fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location_rounded),
            label: 'Маркер',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 3, 204, 30),
        onTap: _onItemTapped,
      ),
    );
  }
}
