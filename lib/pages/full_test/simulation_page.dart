import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toefl/remote/api/full_test_api.dart';
import 'package:toefl/remote/local/shared_pref/test_shared_preferences.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_container.dart';

import '../../models/test/packet.dart';
import '../../models/test/test_status.dart';

class SimulationPage extends StatefulWidget {
  const SimulationPage({super.key});

  @override
  State<SimulationPage> createState() => _SimulationPageState();
}

class _SimulationPageState extends State<SimulationPage> {
  final FullTestApi _fullTestApi = FullTestApi();
  final TestSharedPreference _testSharedPref = TestSharedPreference();
  bool isLoading = true;
  List<Packet> packets = [];
  TestStatus? testStatus;

  void _onInit() async {
    try {
      testStatus = await _testSharedPref.getStatus();
      final allPacket = await _fullTestApi.getAllPacket();
      setState(() {
        packets = allPacket;
        isLoading = false;
      });
    } catch (e) {
      isLoading = false;
    }
  }

  @override
  void initState() {
    _onInit();
    super.initState();
  }

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
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: packets.isNotEmpty
                        ? List.generate(packets.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: PacketCard(
                                  title: packets[index].name,
                                  questionCount: 140,
                                  isDisabled:
                                      !(packets[index].questionCount == 140),
                                  accuracy: packets[index].accuracy,
                                  onTap: () {
                                    if (testStatus != null &&
                                        testStatus!.id == packets[index].id) {
                                      Navigator.of(context)
                                          .pushNamed(
                                              RouteKey.openingLoadingTest,
                                              arguments: packets[index].id)
                                          .then((value) {
                                        if (value != null) {
                                          debugPrint("error: $value");
                                        }
                                      });
                                    } else if (testStatus == null) {
                                      Navigator.of(context)
                                          .pushNamed(
                                              RouteKey.openingLoadingTest,
                                              arguments: packets[index].id)
                                          .then((value) {
                                        if (value != null) {
                                          debugPrint("error: $value");
                                        }
                                      });
                                    }
                                  },
                                  isOnGoing: testStatus != null &&
                                      testStatus!.id == packets[index].id),
                            );
                          })
                        : [],
                  ),
                ),
              ));
  }
}

class PacketCard extends StatelessWidget {
  const PacketCard(
      {super.key,
      required this.title,
      required this.questionCount,
      required this.accuracy,
      required this.onTap,
      required this.isOnGoing,
      this.isDisabled = true});

  final String title;
  final int questionCount;
  final int accuracy;
  final Function() onTap;
  final bool isOnGoing;
  final isDisabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isDisabled) {
          onTap();
        }
      },
      child: Stack(
        children: [
          BlueContainer(
            showShadow: true,
            child: Row(
              // Icon Gaming
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1 / 8,
                  height: MediaQuery.of(context).size.height * 1 / 16,
                  decoration: BoxDecoration(
                    color: HexColor(mariner600),
                    borderRadius: BorderRadius.circular(10),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.62,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Row(
                          children: [
                            Text(
                              title,
                              style: CustomTextStyle.bold16,
                            ),
                            const Spacer(),
                            isOnGoing
                                ? Text(
                                    "On Going",
                                    style: CustomTextStyle.medium14.copyWith(
                                      color: HexColor(colorSuccess),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "140 Questions",
                          style: CustomTextStyle.normal12,
                        ),
                        const SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1 / 3,
                            height: MediaQuery.of(context).size.height * 1 / 64,
                            child: LinearProgressIndicator(
                              backgroundColor: HexColor(neutral40),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  HexColor(mariner700)),
                              value: accuracy / 100,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text("$accuracy%",
                            style: CustomTextStyle.bold16
                                .copyWith(color: HexColor(mariner700)))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: isDisabled
                    ? HexColor(neutral40).withOpacity(0.5)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
