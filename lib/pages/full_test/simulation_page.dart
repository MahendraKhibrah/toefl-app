import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_container.dart';
import 'package:toefl/widgets/toefl_progress_indicator.dart';

class SimulationPage extends StatelessWidget {
  const SimulationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FULL TEST",
          style: CustomTextStyle.extraBold16,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            BlueContainer(
              showShadow: true,
              child: Row(
                // Icon Gaming
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        1 /
                        8, // Sesuaikan lebarnya
                    height: MediaQuery.of(context).size.height *
                        1 /
                        16, // Sesuaikan tingginya
                    decoration: BoxDecoration(
                      color: HexColor(mariner600),
                      // Ganti dengan warna atau dekorasi yang Anda inginkan
                      borderRadius: BorderRadius.circular(
                          10), // Atur radius sesuai kebutuhan
                    ),
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/ic_buku.svg',
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Atur alignment menjadi start
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TEST 1 - ALL PACKET 1',
                        style: CustomTextStyle.bold16,
                      ),
                      Row(
                        children: [
                          Text(
                            "140 Question",
                            style: CustomTextStyle.normal12,
                          ),
                          // Garis lurus
                          const SizedBox(
                              width: 10), // Spacer for some separation
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10), // Atur radius sesuai kebutuhan
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 1 / 3,
                              height:
                                  MediaQuery.of(context).size.height * 1 / 64,
                              child: LinearProgressIndicator(
                                backgroundColor: HexColor(neutral40),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    HexColor(mariner700)),
                                value: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text("80%",
                              style: CustomTextStyle.bold16
                                  .copyWith(color: HexColor(mariner700)))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
