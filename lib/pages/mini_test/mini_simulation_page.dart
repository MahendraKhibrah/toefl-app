import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/test/packet.dart';
import 'package:toefl/models/test/test_status.dart';
import 'package:toefl/pages/full_test/finished_packet_dialog.dart';
import 'package:toefl/pages/full_test/simulation_page.dart';
import 'package:toefl/remote/api/mini_test_api.dart';
import 'package:toefl/remote/local/shared_pref/test_shared_preferences.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/state_management/mini_test_provider.dart';
import 'package:toefl/utils/custom_text_style.dart';

class MiniSimulationPage extends ConsumerStatefulWidget {
  const MiniSimulationPage({super.key});

  @override
  ConsumerState<MiniSimulationPage> createState() => _SimulationPageState();
}

class _SimulationPageState extends ConsumerState<MiniSimulationPage> {
  final MiniTestApi _miniTestApi = MiniTestApi();
  final TestSharedPreference _testSharedPref = TestSharedPreference();
  bool isLoading = true;
  List<Packet> packets = [];
  TestStatus? testStatus;

  void _onInit() async {
    setState(() {
      isLoading = true;
    });
    try {
      final allPacket = await _miniTestApi.getAllPacket();
      setState(() {
        packets = allPacket;
      });
      _handleOnAutoSubmit();
      testStatus = await _testSharedPref.getMiniStatus();

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
      testStatus = await _testSharedPref.getMiniStatus();
      if (testStatus != null) {
        final runningPacket =
            packets.where((element) => element.id == testStatus!.id).first;
        DateTime startTime = DateTime.parse(testStatus!.startTime);
        int diffInSecs = DateTime.now().difference(startTime).inSeconds;
        if (diffInSecs >= 7200) {
          bool submitResult = false;
          if (runningPacket.wasFilled) {
            submitResult =
                await ref.read(miniTestProvider.notifier).resubmitAnswer();
          } else {
            submitResult =
                await ref.read(miniTestProvider.notifier).submitAnswer();
          }
          if (submitResult) {
            await ref.read(miniTestProvider.notifier).resetAll();
          }
        }
      }
    } catch (e) {
      debugPrint("error ho : $e");
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
            "MINI TEST",
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
                                  questionCount: 70,
                                  isDisabled:
                                      !(packets[index].questionCount == 70),
                                  accuracy: packets[index].accuracy,
                                  onTap: () async {
                                    if ((!packets[index].wasFilled) ||
                                        testStatus != null &&
                                            testStatus!.id ==
                                                packets[index].id) {
                                      if (testStatus != null &&
                                          testStatus!.id == packets[index].id) {
                                        Navigator.of(context).pushNamed(
                                            RouteKey.openingMiniTest,
                                            arguments: {
                                              "id": packets[index].id,
                                              "isRetake":
                                                  packets[index].wasFilled,
                                              "packetName": packets[index].name
                                            }).then((value) {
                                          _onInit();
                                        });
                                      } else if (testStatus == null) {
                                        Navigator.of(context).pushNamed(
                                            RouteKey.openingMiniTest,
                                            arguments: {
                                              "id": packets[index].id,
                                              "packetName": packets[index].name,
                                              "isRetake":
                                                  packets[index].wasFilled
                                            }).then((value) {
                                          _onInit();
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
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          RouteKey
                                                              .openingMiniTest,
                                                          arguments: {
                                                        "id": packets[index].id,
                                                        "packetName":
                                                            packets[index].name,
                                                        "isRetake":
                                                            packets[index]
                                                                .wasFilled
                                                      }).then((value) {
                                                    _onInit();
                                                  });
                                                },
                                                onReview: () {
                                                  Navigator.of(submitContext)
                                                      .pop();
                                                  Navigator.pushNamed(context,
                                                      RouteKey.reviewTestPage,
                                                      arguments:
                                                          packets[index].id);
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
