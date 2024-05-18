import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  final List<Map<String, String>> items = [
    {"containerText": "199", "labelText": "Elementary Proficiency"},
    {"containerText": "350", "labelText": "Pre-Intermediate Proficiency"},
    {"containerText": "425", "labelText": "Intermediate Proficiency"},
    {"containerText": "500", "labelText": "Pre-Advanced Proficiency"},
    {"containerText": "550", "labelText": "Advance Proficiency"},
    {"containerText": "660", "labelText": "Special Advance Proficiency"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
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
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return CustomListTile(
                    containerText: items[index]["containerText"]!,
                    labelText: items[index]["labelText"]!,
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

  const CustomListTile({
    Key? key,
    required this.containerText,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlueContainer(
        child: ListTile(
          leading: CustomContainerText(
            text: containerText,
            width: 50,
            height: 50,
            containerColor:
                HexColor(mariner700), // Ganti dengan warna yang diinginkan
            textStyle: CustomTextStyle.bold18.copyWith(color: Colors.white),
            borderRadius: BorderRadius.circular(25),
          ),
          title: Text(
            labelText,
            style: CustomTextStyle.medium15.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
