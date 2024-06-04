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
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.red,
          radius: 40,
          backgroundImage: AssetImage('assets/images/avatar_profile.png'),
        ),
        const SizedBox(
          height: 12,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Skeletonizer(
                enabled: isLoading,
                child: Skeleton.leaf(
                  child: Text(
                    profile?.nameUser ?? 'My Name is Qeli',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Skeletonizer(
                enabled: isLoading,
                child: Skeleton.leaf(
                  child: Text(
                    profile?.emailUser ?? 'myemail@prodi.student.pens.ac.id',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Color(0xFFB0B0B0)),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
