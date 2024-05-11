import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toefl/models/packet_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'full_test_provider.freezed.dart';

@freezed
class FullTestProviderState with _$FullTestProviderState {
  const factory FullTestProviderState({
    required PacketDetail packetDetail,
    @Default(true) bool isLoading,
  }) = _FullTestProviderState;

  const FullTestProviderState._();
}

class FullTestProvider extends StateNotifier<FullTestProviderState> {
  FullTestProvider()
      : super(FullTestProviderState(
            packetDetail: PacketDetail(id: '', name: '', questions: [])));

  void setPacketDetail(PacketDetail packetDetail) {
    state = state.copyWith(packetDetail: packetDetail);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}

final fullTestProvider =
    StateNotifierProvider<FullTestProvider, FullTestProviderState>(
        (ref) => FullTestProvider());
