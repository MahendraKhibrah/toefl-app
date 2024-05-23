import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class ListRank extends StatefulWidget {
  final int index;
  final String name;
  final int score;
  const ListRank(
      {super.key,
      required this.index,
      required this.name,
      required this.score});

  @override
  State<ListRank> createState() => _ListRankState();
}

class _ListRankState extends State<ListRank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 25, // Atur lebar tetap untuk teks indeks
                alignment: Alignment.center, // Ratakan teks ke kanan
                child: Text(
                  widget.index.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              const CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/avatar_profile.png'),
                radius: 25,
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 160, // Atur lebar maksimum teks
                child: Text(
                  widget.name,
                  overflow: TextOverflow.ellipsis, // Tambahkan elipsis
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Container(
              alignment: Alignment.center,
              width: 65,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                shape: BoxShape.rectangle,
                color: HexColor(mariner700),
              ),
              child: Text(
                widget.score.toString(),
                style: TextStyle(
                  color: HexColor(neutral10),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }
}
