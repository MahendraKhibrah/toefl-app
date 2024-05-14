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
}
