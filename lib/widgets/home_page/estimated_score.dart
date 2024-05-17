import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/quiz/modal/modal_confirmation.dart';

class EstimatedScore extends StatelessWidget {
  EstimatedScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: HexColor(mariner900)),
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 65,
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Estimated score",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: HexColor(mariner200),
                                height: 2),
                          ),
                          Text(
                            "Listening score: 272",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: HexColor(neutral10)),
                          ),
                          Text("Structure score: 178",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: HexColor(neutral10))),
                          Text("Reading score: 178",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: HexColor(neutral10))),
                          Text("*take a full test to show here",
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w300,
                                  color: HexColor(neutral10),
                                  height: 2)),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Set Now",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor(mariner900)),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColor(mariner900)),
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ModalConfirmation(
                        message: "Are you sure want to logout this account?",
                        disbleName: "Cancel",
                        enableName: "Logout",
                      );
                    },
                  );
                },
                child: Text(
                  "Try",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: HexColor(mariner900)),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
