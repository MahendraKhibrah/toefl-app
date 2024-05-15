import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toefl/remote/local/shared_pref/auth_shared_preferences.dart';
import 'package:toefl/remote/local/shared_pref/test_shared_preferences.dart';
import 'package:toefl/remote/local/sqlite/full_test_table.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _switchValue = false;
  String dropdownvalue = 'English';
  var items = [
    'English',
    'Indonesia',
  ];
  final AuthSharedPreference authSharedPreference = AuthSharedPreference();
  final TestSharedPreference testSharedPreference = TestSharedPreference();
  final FullTestTable fullTestTable = FullTestTable();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _listTileCustom(Icons.notifications, 'Notification',
              trailing: _switchButton()),
          Divider(
            color: Color(0xffE7E7E7),
            thickness: 1,
          ),
          _listTileCustom(Icons.g_translate, 'Your Language',
              trailing: _dropdownButton()),
          Divider(
            color: Color(0xffE7E7E7),
            thickness: 1,
          ),
          InkWell(
            splashColor: Color(0xffE7E7E7).withOpacity(0.3),
            highlightColor: Colors.transparent,
            onTap: () {},
            child:
                _listTileCustom(Icons.bar_chart_rounded, 'Set my TOEFL Target'),
          ),
          Divider(
            color: Color(0xffE7E7E7),
            thickness: 1,
          ),
          InkWell(
            splashColor: Color(0xffE7E7E7).withOpacity(0.3),
            highlightColor: Colors.transparent,
            onTap: () async {
              await authSharedPreference.removeBearerToken();
              await testSharedPreference.removeStatus();
              await fullTestTable.resetDatabase();
              Navigator.pushReplacementNamed(context, RouteKey.login);
            },
            child:
                _listTileCustom(Icons.logout_sharp, 'Logout', islogout: true),
          )
        ],
      ),
    );
  }

  Widget _listTileCustom(IconData icon, String text,
      {Widget? trailing, bool islogout = false}) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Icon(
        icon,
        color: (islogout ? Color(0xffF44336) : HexColor(mariner800)),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: (islogout ? Color(0xffF44336) : Color(0xff191919)),
        ),
      ),
      trailing: trailing,
    );
  }

  Widget _dropdownButton() {
    return (Container(
      height: 22,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color(0xffF6F6F6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: DropdownButton(
        borderRadius: BorderRadius.circular(15),
        padding: EdgeInsets.symmetric(horizontal: 15),
        value: dropdownvalue,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 20,
          color: Color(0xff191919),
        ),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Color(0xff191919)),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
          });
        },
        underline: Container(),
      ),
    ));
  }

  Widget _switchButton() {
    return (Switch(
      value: _switchValue,
      onChanged: (value) {
        setState(() {
          _switchValue = value;
        });
      },
      activeTrackColor: HexColor(mariner700),
      inactiveTrackColor: Colors.white,
      activeColor: Colors.white,
    ));
  }
}
