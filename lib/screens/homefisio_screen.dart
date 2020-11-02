import 'package:crud_firestore/screens/listapacientes_screen.dart';
import 'package:crud_firestore/screens/profile_fisio_screen.dart';
import 'package:crud_firestore/screens/sessoesfisioscreen.dart';
import 'package:flutter/material.dart';

class HomeFisioScreen extends StatefulWidget {
  //static const route = '/';
  HomeFisioScreen(this.userId, {Key key}) : super(key: key);
  String userId;

  @override
  _HomeFisioScreenState createState() => _HomeFisioScreenState();
}

class _HomeFisioScreenState extends State<HomeFisioScreen> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      _selectedIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          ProfileFisioScreen(),
          SessoesFisioScreen(),
          PacientesFisioScreen()
        ],
        onPageChanged: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Meu perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_sharp),
            label: 'Sessões',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Pacientes',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
