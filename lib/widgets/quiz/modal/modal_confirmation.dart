import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class ModalConfirmation extends StatefulWidget {
  final String message;
  final String leftTitle;
  final String rightTitle;
  final VoidCallback leftFunction;
  final VoidCallback rightFunction;
  const ModalConfirmation(
      {super.key,
      required this.message,
      required this.leftTitle,
      required this.rightTitle,
      required this.leftFunction,
      required this.rightFunction});

  @override
  State<ModalConfirmation> createState() => _ModalConfirmationState();
}

class _ModalConfirmationState extends State<ModalConfirmation> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 20),
            child: Text(
              widget.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor(neutral90),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: widget.rightFunction,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    backgroundColor: HexColor(neutral20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    widget.leftTitle,
                    style: TextStyle(
                      color: HexColor(neutral50),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextButton(
                  onPressed: widget.rightFunction,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    backgroundColor: HexColor(mariner700),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    widget.rightTitle,
                    style: TextStyle(
                      color: HexColor(neutral10),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
