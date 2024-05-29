import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/target_onboarding.dart';
import 'package:toefl/remote/api/onboarding_api.dart';
import 'package:toefl/remote/local/shared_pref/onboarding_shared_preferences.dart';
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
  int isSelected = -1;
  final List<String> reasons = [
    "Graduation Requirement",
    "IISMA",
    "Job",
    "Other"
  ];
  final OnBoardingSharedPreference onBoardingSharedPreference =
      OnBoardingSharedPreference();

  late Future<List<TargetOnboarding>> targetList;

  Future<void> getTargetId() async {
    Future<List<TargetOnboarding>> data = OnBoardingApi().getTarget();
    setState(() {
      targetList = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTargetId();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> icons = [
      SvgPicture.asset(
        'assets/images/graduation.svg',
      ),
      SvgPicture.asset(
        'assets/images/iisma.svg',
      ),
      SvgPicture.asset(
        'assets/images/job.svg',
      ),
      SvgPicture.asset(
        'assets/images/other.svg',
        width: 58,
      ),
    ];

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
              FutureBuilder<List<TargetOnboarding>>(
                  future: targetList,
                  builder: (context, snapshot) {
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: reasons.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                        mainAxisExtent: 180,
                      ),
                      itemBuilder: (context, index) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            snapshot.data!.isEmpty) {
                          return Skeletonizer(
                            enabled: true,
                            child: Skeleton.leaf(
                              child: SetGoalButton(
                                  reasons[index], index, icons[index]),
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              onBoardingSharedPreference
                                  .storeTargetIdUser(snapshot.data![index].id!);

                              setState(() {
                                isSelected = index;
                              });
                            },
                            child: SetGoalButton(
                                reasons[index], index, icons[index]),
                          );
                        }
                      },
                    );
                  }),
              const SizedBox(height: 120),
              BlueButton(
                isDisabled: isSelected == -1,
                title: 'Next',
                onTap: () {
                  if (isSelected != -1) {
                    onBoardingSharedPreference.setOnboardingFalse();
                  }
                  Navigator.popAndPushNamed(context, RouteKey.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container SetGoalButton(String text, int index, Widget icon) {
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
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              icon,
              const SizedBox(height: 20),
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
