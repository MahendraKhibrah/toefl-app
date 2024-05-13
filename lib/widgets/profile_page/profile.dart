import 'package:flutter/material.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class Profile extends StatelessWidget {
  final String nama;
  final String email;
  final ImageProvider foto;
  const Profile(
      {super.key, required this.nama, required this.email, required this.foto});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40,
          backgroundImage: foto,
        ),
        SizedBox(
          width: 12,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.61,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Color(0xFFB0B0B0)),
                  ),
                ],
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
