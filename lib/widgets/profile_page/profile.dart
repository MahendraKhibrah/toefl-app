import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toefl/models/profile.dart' as model;
import 'package:toefl/remote/api/profile_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final profileApi = ProfileApi();
  model.Profile? profile;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void fetchUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      model.Profile temp = await profileApi.getProfile();
      setState(() {
        profile = temp;
      });
    } catch (e) {
      print("Error : $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40,
          backgroundImage: AssetImage('assets/images/avatar_profile.png'),
        ),
        SizedBox(
          width: 12,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.61,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${profile?.nameUser}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "${profile?.emailUser}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Color(0xFFB0B0B0)),
                    ),
                  ],
                ),
              ),
              InkWell(
                splashColor: Color(0xffE7E7E7).withOpacity(0.3),
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.pushNamed(context, RouteKey.editProfile);
                },
                child: CircleAvatar(
                    backgroundColor: HexColor(mariner100),
                    radius: 20,
                    child: Icon(
                      Icons.edit_square,
                      color: HexColor(mariner800),
                    ) //Text
                    ),
              )
            ],
          ),
        )
      ],
    );
  }
}
