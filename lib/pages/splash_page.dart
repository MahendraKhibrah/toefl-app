import 'package:flutter/material.dart';
import 'package:toefl/widgets/border_button.dart';

import '../widgets/answer_button.dart';
import '../widgets/answer_validation_container.dart';
import '../widgets/blue_button.dart';
import '../widgets/blue_container.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlueButton(
              title: 'Retake',
              onTap: () {},
            ),
            const SizedBox(
              height: 15,
            ),
            BlueButton(
              title: 'Disable Button',
              onTap: () {},
              isDisabled: true,
              size: 300,
            ),
            const SizedBox(
              height: 15,
            ),
            const BlueContainer(
              child: Text("test test test\ntest test\ntest "
                  "skdmskdm sdkfmsdkfm ksdmfksdmf sdkfmskfm skfmskmf"),
            ),
            const SizedBox(
              height: 15,
            ),
            BorderButton(
              title: 'Cancel',
              onTap: () {},
            ),
            const SizedBox(
              height: 15,
            ),
            AnswerButton(
              onTap: () {},
              title: 'INI BISA DIPENCET',
            ),
            const SizedBox(
              height: 15,
            ),
            AnswerButton(
              isAnswerTrue: true,
              onTap: () {},
              title:
                  '(A) APAKAH SUDAH MAKAN? akdmakdm akdmakdm akdmadkm akdmadkm'
                  'ssd,ls,dl,djnajdna aakdak akdmak',
            ),
            const SizedBox(
              height: 15,
            ),
            const AnswerValidationContainer(
              isCorrect: true,
              keyAnswer: '(B) Agile ini Bosenin Banget sih haduh aaa aa aaa aa',
              explanation:
                  'lorem ipsum dolor sit amet hehe hehe hehhhhh eheh weh',
            ),
            const SizedBox(
              height: 15,
            ),
            const AnswerValidationContainer(
              isCorrect: false,
              keyAnswer: '(B) Agile ini Bosenin Banget sih haduh aaa aa aaa aa',
              explanation:
                  'lorem ipsum dolor sit amet hehe hehe hehhhhh eheh weh',
            ),
          ],
        ),
      ),
    );
  }
}
