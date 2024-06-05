import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/profile.dart';
import 'package:toefl/remote/env.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class ProfileNameSection extends StatelessWidget {
  const ProfileNameSection({
    super.key,
    required this.profile,
    required this.isLoading,
  });

  final Profile profile;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        profile.profileImage.isNotEmpty
            ? CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 40,
                backgroundImage: NetworkImage(
                    "${Env.storageUrl}/toefl/${profile.profileImage}"))
            : CircleAvatar(
                backgroundColor: HexColor(neutral10),
                radius: 40,
                child: Image.asset('assets/images/avatar_profile.png'),
              ),
        const SizedBox(
          height: 12,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Skeleton.leaf(
                child: Text(
                  profile.nameUser.isNotEmpty
                      ? profile.nameUser
                      : 'My Name is Qeli',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Skeleton.leaf(
                child: Text(
                  profile.emailUser.isNotEmpty
                      ? profile.emailUser
                      : 'myemail@prodi.student.pens.ac.id',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Color(0xFFB0B0B0)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
