import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:toefl/models/test/packet_detail.dart';
import 'package:toefl/remote/api/full_test_api.dart';

@GenerateNiceMocks([MockSpec<FullTestApi>()])
import 'mini_test_api_test.mocks.dart';

void main() {
  final FullTestApi finalFullTestApi = MockFullTestApi();

  final PacketDetail packetDetail = PacketDetail(
    id: "1",
    name: "Test",
    questions: const [],
  );

  final PacketDetail packetDetailFail = PacketDetail(
    id: "",
    name: "",
    questions: const [],
  );

  group("Mini Test Api", () {
    group("getPacketDetail", () {
      test("IF SUCCESS", () async {
        when(finalFullTestApi.getPacketDetail("x")).thenAnswer((_) async {
          return packetDetail;
        });

        try {
          final result = await finalFullTestApi.getPacketDetail("x");
          expect(result, packetDetail);
        } catch (e) {
          fail("Should not throw an error");
        }
      });

      test("IF NOT GET DATA", () async {
        when(finalFullTestApi.getPacketDetail("y")).thenAnswer((_) async {
          return packetDetailFail;
        });

        try {
          final result = await finalFullTestApi.getPacketDetail("y");
          expect(result, packetDetailFail);
        } catch (e) {
          fail("Should not throw an error");
        }
      });
    });
  });
}
