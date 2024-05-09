import 'package:flutter/material.dart';
import 'package:toefl/pages/games_page.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarBottom extends StatefulWidget {
  const NavBarBottom({super.key});

  @override
  State<NavBarBottom> createState() => _NavBarBottomState();
}

class _NavBarBottomState extends State<NavBarBottom> {
  late int _index;

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
    ),
    GamesPage(),
    Text(
      'Index 2: School',
    ),
  ];
  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_index),
      bottomNavigationBar: Container(
        height: 75,
        decoration: BoxDecoration(boxShadow: [BoxShadow()]),
        child: BottomNavigationBar(
          iconSize: 30,
          currentIndex: _index,
          onTap: (int _index) {
            setState(() {
              this._index = _index;
            });
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          unselectedLabelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: HexColor(neutral40)),
          selectedLabelStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: HexColor(mariner800)),
          unselectedIconTheme: IconThemeData(color: HexColor(neutral40)),
          selectedIconTheme: IconThemeData(color: HexColor(mariner800)),
          unselectedItemColor: HexColor(neutral40),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 32,
                child: SvgPicture.asset(
                  // ignore: deprecated_member_use
                  color:
                      _index == 1 ? HexColor(mariner800) : HexColor(neutral40),
                  'assets/icons/ic_games.svg',
                  height: 25,
                  width: 30,
                  clipBehavior: Clip.none,
                ),
              ),
              label: 'Games',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_rounded,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
