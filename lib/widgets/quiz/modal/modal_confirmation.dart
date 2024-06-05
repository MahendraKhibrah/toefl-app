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
  final bool isWarningModal;

  const ModalConfirmation(
      {super.key,
      required this.message,
      required this.leftTitle,
      required this.rightTitle,
      required this.leftFunction,
      required this.rightFunction,
      this.isWarningModal = false});

  @override
  State<ModalConfirmation> createState() => _ModalConfirmationState();
}

class _ModalConfirmationState extends State<ModalConfirmation> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 40),
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
                    onPressed: widget.leftFunction,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      backgroundColor: widget.isWarningModal
                          ? HexColor(neutral40).withOpacity(0.35)
                          : HexColor(neutral10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: widget.isWarningModal
                                  ? Colors.transparent
                                  : HexColor(mariner700))),
                    ),
                    child: Text(
                      widget.leftTitle,
                      style: TextStyle(
                        color: widget.isWarningModal
                            ? HexColor(neutral50)
                            : HexColor(mariner700),
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
                      backgroundColor: widget.isWarningModal
                          ? HexColor(colorError)
                          : HexColor(mariner700),
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
      ),
    );
  }
}
