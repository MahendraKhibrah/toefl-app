import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_auth/local_auth.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toefl/remote/local/shared_pref/auth_shared_preferences.dart';
import 'package:toefl/remote/local/shared_pref/localization_shared_pref.dart';
import 'package:toefl/remote/local/shared_pref/test_shared_preferences.dart';
import 'package:toefl/remote/local/sqlite/full_test_table.dart';
import 'package:toefl/remote/local/sqlite/mini_test_table.dart';
import 'package:toefl/routes/local_notification.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/utils/locale.dart';
import 'package:toefl/widgets/profile_page/change_lang_dialog.dart';
import '../quiz/modal/modal_confirmation.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}



class _SettingState extends State<Setting> {
  bool _switchValue = false;
  String dropdownValue = 'English';
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
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

  final LocalAuthentication auth = LocalAuthentication();

  void _onInit() async {
    final selectedLang = await localizationSharedPreference.getSelectedLang();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dropdownValue = (selectedLang?.startsWith(LocaleEnum.id.name) ?? false)
          ? 'Indonesia'
          : "English";
      _switchValue = (prefs.getBool('switchState') ?? false);
    });
  }

  @override
  void initState() {
    super.initState();
    _onInit();
    NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  }

  _saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('switchState', value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _listTileCustom(Icons.notifications, 'notification'.tr(),
              trailing: _switchButton()),
          const Divider(
            color: Color(0xffE7E7E7),
            thickness: 1,
          ),
          _listTileCustom(Icons.g_translate, 'language'.tr(),
              trailing: _dropdownButton()),
          const Divider(
            color: Color(0xffE7E7E7),
            thickness: 1,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: const Color(0xffE7E7E7).withOpacity(0.3),
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pushNamed(context, RouteKey.setTargetPage);
            },
            child: _listTileCustom(
                Icons.bar_chart_rounded, 'set_toefl_target'.tr()),
          ),
          const Divider(
            color: Color(0xffE7E7E7),
            thickness: 1,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: const Color(0xffE7E7E7).withOpacity(0.3),
            highlightColor: Colors.transparent,
            onTap: () async {
              final bool canAuthenticateWithBiometrics =
                  await auth.canCheckBiometrics;
              final bool canAuthenticate = canAuthenticateWithBiometrics ||
                  await auth.isDeviceSupported();

              try {
                final bool didAuthenticate = await auth.authenticate(
                    localizedReason: 'Please authenticate to change password');
                if (didAuthenticate) {
                  Navigator.pushNamed(context, RouteKey.resetPassword,
                      arguments: true);
                }
              } catch (e) {
                // ...
              }
            },
            child: _listTileCustom(Icons.password, 'change_password'.tr()),
          ),
          Divider(
            color: const Color(0xffE7E7E7).withOpacity(0.3),
            thickness: 1,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: const Color(0xffE7E7E7).withOpacity(0.3),
            highlightColor: Colors.transparent,
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext submitContext) {
                  return ModalConfirmation(
                    message: "are_you_sure_want_to_logout_this_account".tr(),
                    leftTitle: 'cancel'.tr(),
                    rightTitle: 'logout'.tr(),
                    isWarningModal: true,
                    rightFunction: () async {
                      await authSharedPreference.removeBearerToken();
                      await authSharedPreference.removeVerifiedAccount();
                      await testSharedPreference.removeStatus();
                      await testSharedPreference.removeMiniStatus();
                      await fullTestTable.resetDatabase();
                      await miniTestTable.resetDatabase();
                      if (submitContext.mounted) {
                        Navigator.of(submitContext).pop();
                      }
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, RouteKey.login);
                      }
                    },
                    leftFunction: () {
                      Navigator.of(submitContext).pop();
                    },
                  );
                },
              );
            },
            child: _listTileCustom(Icons.logout_sharp, 'logout'.tr(),
                islogout: true),
          )
        ],
      ),
    );
  }

  Widget _listTileCustom(IconData icon, String text,
      {Widget? trailing, bool islogout = false}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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
                await localizationSharedPreference.saveSelectedLang(
                    newValue == 'English'
                        ? LocaleEnum.en.name
                        : LocaleEnum.id.name);
                setState(() {
                  dropdownValue = newValue!;
                });
                Restart.restartApp();
              }
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
      onChanged: (value) async {
        setState(() {
          _switchValue = value;
          _saveSwitchState(value);
        });
        if (value) {
          scheduleNotifications();
        }
      },
      activeTrackColor: HexColor(mariner700),
      inactiveTrackColor: Colors.white,
      activeColor: Colors.white,
    ));
  }


  void scheduleNotifications() {
    DateTime now = DateTime.now();
    DateTime nextMorning =
        DateTime(now.year, now.month, now.day, 10, 0, 0).add(
      now.hour >= 10 ? Duration(days: 1) : Duration.zero,
    );
    DateTime nextAfternoon = DateTime(now.year, now.month, now.day, 14, 58, 0).add(
      now.hour >= 16 ? Duration(days: 1) : Duration.zero,
    );

    Duration morningDuration = nextMorning.difference(now);
    Duration eveningDuration = nextAfternoon.difference(now);

    // Timer for morning notification
    Timer(morningDuration, () {
      NotificationHelper.showBigTextNotification(
        title: 'morning_notification'.tr(args: ['Sobat TOEFL PENS!']),
        body: 'body_notification'.tr(),
        fln: flutterLocalNotificationsPlugin,
      );
      // Schedule next morning notification
      scheduleNotifications();
    });

    // Timer for evening notification
    Timer(eveningDuration, () {
      NotificationHelper.showBigTextNotification(
        title: 'afternoon_notification'.tr(args: ['Sobat TOEFL PENS!']),
        body: 'body_notification'.tr(),
        fln: flutterLocalNotificationsPlugin,
      );
      // Schedule next evening notification
      scheduleNotifications();
    });
  }
}
