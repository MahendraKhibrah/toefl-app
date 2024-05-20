import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/pages/full_test/finished_packet_dialog.dart';
import 'package:toefl/remote/api/full_test_api.dart';
import 'package:toefl/remote/local/shared_pref/test_shared_preferences.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/state_management/full_test_provider.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_container.dart';

import '../../models/test/packet.dart';
import '../../models/test/test_status.dart';

class SimulationPage extends ConsumerStatefulWidget {
  const SimulationPage({super.key});

  @override
  ConsumerState<SimulationPage> createState() => _SimulationPageState();
}

class _SimulationPageState extends ConsumerState<SimulationPage> {
  final FullTestApi _fullTestApi = FullTestApi();
  final TestSharedPreference _testSharedPref = TestSharedPreference();
  bool isLoading = true;
  List<Packet> packets = [];
  TestStatus? testStatus;

  void _onInit() async {
    setState(() {
      isLoading = true;
    });
    try {
      final allPacket = await _fullTestApi.getAllPacket();
      setState(() {
        packets = allPacket;
      });
      _handleOnAutoSubmit();
      testStatus = await _testSharedPref.getStatus();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _handleOnAutoSubmit() async {
    try {
      testStatus = await _testSharedPref.getStatus();
      if (testStatus != null) {
        final runningPacket =
            packets.where((element) => element.id == testStatus!.id).first;
        DateTime startTime = DateTime.parse(testStatus!.startTime);
        int diffInSecs = DateTime.now().difference(startTime).inSeconds;
        if (diffInSecs >= 7200) {
          bool submitResult = false;
          if (runningPacket.wasFilled) {
            submitResult =
                await ref.read(fullTestProvider.notifier).resubmitAnswer();
          } else {
            submitResult =
                await ref.read(fullTestProvider.notifier).submitAnswer();
          }
          if (submitResult) {
            await ref.read(fullTestProvider.notifier).resetAll();
          }
        }
      }
    } catch (e) {
      debugPrint("error ho : $e");
    }
  }

  void _pushReviewPage(Packet packet) {
    Navigator.pushNamed(context, RouteKey.testresult, arguments: {
      "packetId": packet.id,
      "isMiniTest": false,
      "packetName": packet.name
    }).then((afterRetake) {
      if (afterRetake == true) {
        _onInit();
        _pushReviewPage(packet);
      }
    });
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SingleChildScrollView(
            child: Skeletonizer(
              enabled: isLoading,
              child: Column(
                children: isLoading
                    ? List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Skeleton.leaf(
                              child: PacketCard(
                                  title: "",
                                  questionCount: 0,
                                  accuracy: 0,
                                  onTap: () {},
                                  isOnGoing: false,
                                  isDisabled: true)),
                        ),
                      )
                    : packets.isNotEmpty
                        ? List.generate(packets.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: PacketCard(
                                  title: packets[index].name,
                                  questionCount: 140,
                                  isDisabled:
                                      !(packets[index].questionCount == 140),
                                  accuracy: packets[index].accuracy,
                                  onTap: () async {
                                    if ((!packets[index].wasFilled) ||
                                        testStatus != null &&
                                            testStatus!.id ==
                                                packets[index].id) {
                                      if (testStatus != null &&
                                          testStatus!.id == packets[index].id) {
                                        Navigator.of(context).pushNamed(
                                            RouteKey.openingLoadingTest,
                                            arguments: {
                                              "id": packets[index].id,
                                              "isRetake":
                                                  packets[index].wasFilled,
                                              "packetName": packets[index].name
                                            }).then((value) {
                                          _onInit();
                                          _pushReviewPage(packets[index]);
                                        });
                                      } else if (testStatus == null) {
                                        Navigator.of(context).pushNamed(
                                            RouteKey.openingLoadingTest,
                                            arguments: {
                                              "id": packets[index].id,
                                              "packetName": packets[index].name,
                                              "isRetake":
                                                  packets[index].wasFilled
                                            }).then((value) {
                                          _onInit();
                                          _pushReviewPage(packets[index]);
                                        });
                                      }
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext submitContext) {
                                          return AlertDialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 0),
                                              content: FinishedPacketDialog(
                                                onRetake: () {
                                                  Navigator.of(submitContext)
                                                      .pop();
                                                  Navigator.of(context).pushNamed(
                                                      RouteKey
                                                          .openingLoadingTest,
                                                      arguments: {
                                                        "id": packets[index].id,
                                                        "packetName":
                                                            packets[index].name,
                                                        "isRetake":
                                                            packets[index]
                                                                .wasFilled
                                                      }).then((value) {
                                                    _onInit();
                                                    _pushReviewPage(
                                                        packets[index]);
                                                  });
                                                },
                                                onReview: () {
                                                  Navigator.of(submitContext)
                                                      .pop();
                                                  Navigator.pushNamed(context,
                                                      RouteKey.testresult,
                                                      arguments: {
                                                        "packetId":
                                                            packets[index].id,
                                                        "isMiniTest": false,
                                                        "packetName":
                                                            packets[index].name
                                                      }).then((afterRetake) {
                                                    if (afterRetake == true) {
                                                      _onInit();
                                                      _pushReviewPage(
                                                          packets[index]);
                                                    }
                                                  });
                                                },
                                              ));
                                        },
                                      );
                                    }
                                  },
                                  isOnGoing: testStatus != null &&
                                      testStatus!.id == packets[index].id),
                            );
                          })
                        : [],
              ),
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
                          "$questionCount Questions",
                          style: CustomTextStyle.normal12,
                        ),
                        const SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
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
