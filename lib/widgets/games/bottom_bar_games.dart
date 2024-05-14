import 'package:flutter/material.dart';
import 'package:toefl/models/game.dart';
import 'package:toefl/models/games/game_detail.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBarGames extends StatelessWidget implements PreferredSizeWidget {
  final GameDetail game;
  final Size preferredSize;
  final bool isActive;
  final VoidCallback onPressed;

  const BottomBarGames({
    Key? key,
    required this.game,
    required this.preferredSize,
    required this.isActive,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: preferredSize.height,
        decoration: BoxDecoration(
          color: HexColor(mariner100),
          // border: Border(top: BorderSide(color: Colors.black)),
        ),
        child: Center(
          child: ListTile(
            onTap: onPressed,
            leading: isActive
                ? Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6)),
                  )
                : null,
            title: RichText(
              text: TextSpan(
                  text: game.title,
                  style: GoogleFonts.nunito(
                      color: HexColor(mariner900),
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                  children: [
                    TextSpan(
                      text: ' Level ' + game.level.toString(),
                      style: GoogleFonts.nunito(
                          color: HexColor(mariner800),
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    )
                  ]),
            ),
            subtitle: isActive
                ? Text(
                    game.description,
                    maxLines: 2,
                  )
                : null,
            trailing: IconButton(
              onPressed: onPressed,
              isSelected: isActive,
              iconSize: 32,
              selectedIcon: Icon(
                Icons.keyboard_arrow_up_rounded,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
              ),
            ),
          ),
        ));
  }
}
