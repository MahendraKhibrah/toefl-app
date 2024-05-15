import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_button.dart';

class SetGoal extends StatefulWidget {
  const SetGoal({
    super.key,
  });

  @override
  State<SetGoal> createState() => _SetGoalState();
}

class _SetGoalState extends State<SetGoal> {
  int isSelected = 0;
  final List<String> reasons = [
    "IISMA",
    "Graduation Requirement",
    "Job",
    "Other"
  ];

  final List<IconData> icon = [
    Icons.abc,
    Icons.search,
    Icons.work,
    Icons.more_horiz
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 56),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Why do you want to learn TOEFL?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: HexColor(mariner700),
                ),
              ),
              Text(
                "Choose your reason for learning TOEFL",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: HexColor(neutral50),
                ),
              ),
              const SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  mainAxisExtent: 180,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected = index;
                      });
                    },
                    child: SetGoalButton(reasons[index], index, icon[index]),
                  );
                },
              ),
              const SizedBox(height: 120),
              BlueButton(
                title: 'Next', 
                onTap: () {
                  Navigator.popAndPushNamed(context, RouteKey.login);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container SetGoalButton(String text, int index, IconData icon) {
    return Container(
      width: 128,
      height: 150,
      decoration: BoxDecoration(
        color:
            isSelected == index ? HexColor(mariner700) : HexColor(mariner100),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 23),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(icon),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected == index
                      ? HexColor(neutral10)
                      : HexColor(neutral60),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
