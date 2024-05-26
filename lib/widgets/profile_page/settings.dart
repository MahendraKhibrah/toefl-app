import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toefl/remote/local/shared_pref/auth_shared_preferences.dart';
import 'package:toefl/remote/local/shared_pref/localization_shared_pref.dart';
import 'package:toefl/remote/local/shared_pref/test_shared_preferences.dart';
import 'package:toefl/remote/local/sqlite/full_test_table.dart';
import 'package:toefl/remote/local/sqlite/mini_test_table.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/utils/locale.dart';
import 'package:toefl/widgets/profile_page/change_lang_dialog.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _switchValue = false;
  String dropdownValue = 'English';
  var items = [
    'English',
    'Indonesia',
  ];
  final AuthSharedPreference authSharedPreference = AuthSharedPreference();
  final TestSharedPreference testSharedPreference = TestSharedPreference();
  final LocalizationSharedPreference localizationSharedPreference =
      LocalizationSharedPreference();
  final FullTestTable fullTestTable = FullTestTable();
  final MiniTestTable miniTestTable = MiniTestTable();

  void _onInit() async {
    final selectedLang = await localizationSharedPreference.getSelectedLang();
    setState(() {
      dropdownValue = (selectedLang?.startsWith(LocaleEnum.id.name) ?? false)
          ? 'Indonesia'
          : "English";
    });
  }

  @override
  void initState() {
    super.initState();
    _onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _listTileCustom(Icons.notifications, 'Notification',
              trailing: _switchButton()),
          const Divider(
            color: Color(0xffE7E7E7),
            thickness: 1,
          ),
          _listTileCustom(Icons.g_translate, 'Your Language',
              trailing: _dropdownButton()),
          const Divider(
            color: Color(0xffE7E7E7),
            thickness: 1,
          ),
          InkWell(
            splashColor: const Color(0xffE7E7E7).withOpacity(0.3),
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pushNamed(context, RouteKey.setTargetPage);
            },
            child:
                _listTileCustom(Icons.bar_chart_rounded, 'Set my TOEFL Target'),
          ),
          const Divider(
            color: Color(0xffE7E7E7),
            thickness: 1,
          ),
          InkWell(
            splashColor: const Color(0xffE7E7E7).withOpacity(0.3),
            highlightColor: Colors.transparent,
            onTap: () async {
              await authSharedPreference.removeBearerToken();
              await testSharedPreference.removeStatus();
              await testSharedPreference.removeMiniStatus();
              await fullTestTable.resetDatabase();
              await miniTestTable.resetDatabase();
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
      contentPadding: const EdgeInsets.all(0),
      leading: Icon(
        icon,
        color: (islogout ? const Color(0xffF44336) : HexColor(mariner800)),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: (islogout ? const Color(0xffF44336) : const Color(0xff191919)),
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
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: const Color(0xffF6F6F6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: DropdownButton(
        borderRadius: BorderRadius.circular(15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        value: dropdownValue,
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
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Color(0xff191919)),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) async {
          if (newValue != dropdownValue) {
            await showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                    backgroundColor: Colors.transparent,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    content: ChangeLangDialog(
                      onNo: () {
                        Navigator.of(dialogContext).pop(false);
                      },
                      onYes: () {
                        Navigator.of(dialogContext).pop(true);
                      },
                    ));
              },
            ).then((value) async {
              if (value == true) {
                localizationSharedPreference.saveSelectedLang(
                    newValue == 'English'
                        ? LocaleEnum.en.name
                        : LocaleEnum.id.name);
              }
              setState(() {
                dropdownValue = newValue!;
              });
            });
          }
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
