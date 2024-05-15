import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:toefl/models/test/packet_detail.dart';
import 'package:toefl/remote/dio_toefl.dart';

import '../../models/test/packet.dart';
import '../base_response.dart';
import '../env.dart';

class FullTestApi {
  Future<PacketDetail> getPacketDetail(String id) async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.apiUrl}/get-pakets/$id');

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return PacketDetail.fromJson(response.data);
    } catch (e) {
      return PacketDetail(id: "", name: "", questions: []);
    }
  }

  Future<List<Packet>> getAllPacket() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.apiUrl}/get-all-paket/full-test');

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return (response.data as List<dynamic>)
          .map((e) => Packet.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('error get all packet: $e');
      return [];
    }
  }

  Future<bool> submitAnswer(
      List<Map<String, dynamic>> request, String packetId) async {
    try {
      final Response rawResponse = await DioToefl.instance.post(
        '${Env.apiUrl}/submit-paket/$packetId',
        data: {"answers": request},
      );

      if ((rawResponse.statusCode ?? 0) >= 200 &&
          (rawResponse.statusCode ?? 0) < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('error submit answer: $e');
      return false;
    }
  }

  Future<bool> resubmitAnswer(
      List<Map<String, dynamic>> request, String packetId) async {
    try {
      final Response rawResponse = await DioToefl.instance.patch(
        '${Env.apiUrl}/retake-test/$packetId',
        data: {"answers": request},
      );

      if ((rawResponse.statusCode ?? 0) >= 200 &&
          (rawResponse.statusCode ?? 0) < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('error submit answer: $e');
      return false;
    }
  }
}
