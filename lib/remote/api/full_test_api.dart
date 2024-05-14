import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:toefl/models/test/packet_detail.dart';
import 'package:toefl/remote/dio_toefl.dart';

import '../base_response.dart';
import '../env.dart';

class FullTestApi {
  Future<PacketDetail> getPacketDetail() async {
    try {
      final Response rawResponse = await DioToefl.instance
          .get('${Env.apiUrl}/get-pakets/66313a811b703e05e00f0c68');

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return PacketDetail.fromJson(response.data);
    } catch (e) {
      return PacketDetail(id: "", name: "", questions: []);
    }
  }
}
