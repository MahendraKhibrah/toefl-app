import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/profile.dart' as model;
import 'package:toefl/remote/api/profile_api.dart';

class ProfileNameSection extends StatefulWidget {
  const ProfileNameSection({super.key});

  @override
  State<ProfileNameSection> createState() => _ProfileNameSectionState();
}

class _ProfileNameSectionState extends State<ProfileNameSection> {
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
      print(temp);
      setState(() {
        profile = temp;
      });
    } catch (e) {
      print("Error : $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
                    Skeletonizer(
                      enabled: isLoading,
                      child: Skeleton.leaf(
                        child: Text(
                          "${profile?.nameUser ?? 'My Name is Qeli'}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    Skeletonizer(
                      enabled: isLoading,
                      child: Skeleton.leaf(
                        child: Text(
                          "${profile?.emailUser ?? 'myemail@prodi.student.pens.ac.id'}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Color(0xFFB0B0B0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // InkWell(
              //   splashColor: Color(0xffE7E7E7).withOpacity(0.3),
              //   highlightColor: Colors.transparent,
              //   onTap: () {
              //     Navigator.pushNamed(context, RouteKey.editProfile);
              //   },
              //   child: CircleAvatar(
              //       backgroundColor: HexColor(mariner100),
              //       radius: 20,
              //       child: Icon(
              //         Icons.edit_square,
              //         color: HexColor(mariner800),
              //       ) //Text
              //       ),
              // )
            ],
          ),
        )
      ],
    );
  }
}
