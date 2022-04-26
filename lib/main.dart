import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Screens/Welcome/welcome_screen.dart';
import 'constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Eventor Auth",
      theme: ThemeData(
          primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
      home: const WelcomeScreen(),
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
  final Widget _myGoogleMap = const GoogleMapScreen();

  // static const List<Widget> _widgetTitle = <Widget>[
  //   Text(
  //     'Главная',
  //     style: TextStyle(
  //         color: Colors.amber, fontSize: 40, fontWeight: FontWeight.bold),
  //   ),
  //   Text(
  //     'Создание маркера',
  //     style: TextStyle(
  //         color: Colors.amber, fontSize: 40, fontWeight: FontWeight.bold),
  //   ),
  //   Text(
  //     'Профиль',
  //     style: TextStyle(
  //         color: Colors.amber, fontSize: 40, fontWeight: FontWeight.bold),
  //   ),
  // ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        // appBar: AppBar(
        //   title: _widgetTitle.elementAt(_selectedIndex),
        // ),
        body: getBody(),
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
          selectedItemColor: const Color.fromARGB(255, 3, 204, 30),
          onTap: _onItemTapped,
        ),
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

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(45.039859, 38.975166),
          zoom: 15,
        ),
      ),
    );
  }
}
