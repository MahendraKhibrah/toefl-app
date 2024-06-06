import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toefl/pages/games/games_page.dart';
import 'package:toefl/pages/home_page.dart';
import 'package:toefl/pages/user/profile_page.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _index;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    GamesPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_index),
      bottomNavigationBar: Container(
        height: 75,
        decoration:
            const BoxDecoration(boxShadow: [BoxShadow()], color: Colors.white),
        child: BottomNavigationBar(
          backgroundColor: HexColor(neutral10),
          iconSize: 30,
          currentIndex: _index,
          onTap: (int index) {
            setState(() {
              _index = index;
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
              label: 'first_label_navbar'.tr(),
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
              label: 'second_label_navbar'.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_rounded,
              ),
              label: 'third_label_navbar'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
