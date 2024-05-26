import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toefl/models/test/test_target.dart';
import 'package:toefl/remote/api/user_api.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_container.dart';

class SetTargetPage extends StatefulWidget {
  const SetTargetPage({super.key});

  @override
  State<SetTargetPage> createState() => _SetTargetPageState();
}

class _SetTargetPageState extends State<SetTargetPage> {
  TestTarget selectedTarget = TestTarget(
    id: "",
    name: "",
    score: 0,
  );

  List<TestTarget> allTargets = [];
  UserApi api = UserApi();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _onInit();
  }

  void _onInit() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserTarget userTarget = await api.getUserTarget();
      setState(() {
        selectedTarget = userTarget.selectedTarget;
        allTargets = userTarget.allTargets;
      });
      debugPrint("selectedTarget: ${selectedTarget.id}");
    } catch (e) {
      debugPrint("Error in _onInit: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "SET YOUR OWN\nTOEFL TARGET!",
              style: CustomTextStyle.extrabold20.copyWith(color: Colors.black),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView.builder(
                itemCount: allTargets.length,
                itemBuilder: (context, index) {
                  return CustomListTile(
                    containerText: allTargets[index].score.toString(),
                    labelText: allTargets[index].name,
                    isSelected: selectedTarget.id == allTargets[index].id,
                    onTap: () async {
                      setState(() {
                        selectedTarget = allTargets[index];
                      });
                      await api.updateBookmark(selectedTarget.id);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomContainerText extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color containerColor;
  final TextStyle textStyle;
  final BorderRadiusGeometry borderRadius;

  const CustomContainerText({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.containerColor,
    required this.textStyle,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: borderRadius,
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String containerText;
  final String labelText;
  final bool isSelected;
  final Function() onTap;

  const CustomListTile({
    Key? key,
    required this.containerText,
    required this.labelText,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          if (isSelected) {
            debugPrint("Already selected");
            return;
          } else {
            debugPrint("Not selected yet");
            onTap();
          }
        },
        child: Stack(
          children: [
            BlueContainer(
              showShadow: isSelected,
              child: ListTile(
                leading: CustomContainerText(
                  text: containerText,
                  width: 50,
                  height: 50,
                  containerColor: HexColor(mariner700),
                  textStyle:
                      CustomTextStyle.bold18.copyWith(color: Colors.white),
                  borderRadius: BorderRadius.circular(25),
                ),
                title: Text(
                  labelText,
                  style: CustomTextStyle.medium15.copyWith(color: Colors.black),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: !isSelected
                      ? HexColor(neutral40).withOpacity(0.3)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
