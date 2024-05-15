import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toefl/models/test/packet_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:toefl/models/test/test_status.dart';
import 'package:toefl/remote/api/full_test_api.dart';
import 'package:toefl/remote/local/shared_pref/test_shared_preferences.dart';
import 'package:toefl/remote/local/sqlite/full_test_table.dart';

part 'full_test_provider.freezed.dart';

@freezed
class FullTestProviderState with _$FullTestProviderState {
  const factory FullTestProviderState(
      {required PacketDetail packetDetail,
      @Default([]) List<Question> selectedQuestions,
      @Default(true) bool isLoading,
      @Default(false) bool isSubmitLoading,
      @Default([]) List<bool> questionsFilledStatus,
      required TestStatus testStatus}) = _FullTestProviderState;

  const FullTestProviderState._();
}

class FullTestProvider extends StateNotifier<FullTestProviderState> {
  FullTestProvider()
      : super(FullTestProviderState(
            packetDetail: PacketDetail(id: '', name: '', questions: []),
            selectedQuestions: [],
            questionsFilledStatus: [],
            testStatus: TestStatus(
                id: '', startTime: '', resetTable: false, name: ''))) {
    // _onInit();
  }

  final FullTestTable _fullTestTable = FullTestTable();
  final FullTestApi _fullTestApi = FullTestApi();
  final TestSharedPreference _testSharedPref = TestSharedPreference();

  Future<void> onInit() async {
    try {
      var newPacketDetail = PacketDetail(
          id: state.packetDetail.id,
          name: state.packetDetail.name,
          questions: state.packetDetail.questions);
      state = state.copyWith(isLoading: true, packetDetail: newPacketDetail);
      final testStat = await _testSharedPref.getStatus();
      if (testStat != null) {
        if (testStat.resetTable) {
          await _testSharedPref.saveStatus(TestStatus(
              id: testStat.id,
              startTime: testStat.startTime,
              name: testStat.name,
              resetTable: false));
          await initPacketDetail(testStat.id).then((val) {
            getQuestionByNumber(1);
          });
        } else {
          getQuestionByNumber(1);
        }
        state = state.copyWith(testStatus: testStat);
      }
    } catch (e) {
      debugPrint("error: $e");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> resetPacketTable() async {
    await _fullTestTable.resetDatabase();
  }

  Future<void> resetTestStatus() async {
    await _testSharedPref.removeStatus();
  }

  Future<bool> initPacketDetail(String id) async {
    try {
      await resetPacketTable();
      await _getPacketDetailFromApi(id);
      await _insertQuestionsToLocal();
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  Future<void> _getPacketDetailFromApi(String id) async {
    try {
      final packetDetail = await _fullTestApi.getPacketDetail(id);
      state = state.copyWith(packetDetail: packetDetail);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _insertQuestionsToLocal() async {
    try {
      final packetDetail = state.packetDetail;
      for (var i = 0; i < packetDetail.questions.length; i++) {
        final question = packetDetail.questions[i];
        _fullTestTable.insertQuestion(question, (i + 1));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getQuestionByNumber(int number) async {
    var ableToGet = true;
    for (var element in state.selectedQuestions) {
      if (element.number == number) {
        ableToGet = false;
      }
    }

    if (ableToGet) {
      state = state.copyWith(isLoading: true, selectedQuestions: []);
      await Future.delayed(const Duration(milliseconds: 50));
      try {
        final question = await _fullTestTable.getQuestionByNumber(number);
        if (question.nestedQuestionId.isNotEmpty) {
          final nestedQuestion = await _fullTestTable
              .getQuestionsByGroupId(question.nestedQuestionId);
          state = state.copyWith(selectedQuestions: nestedQuestion);
        } else {
          state = state.copyWith(
              selectedQuestions: List.generate(1, (index) => question));
        }
      } catch (e) {
        debugPrint("error : $e");
      } finally {
        final filledStatus = await getQuestionsFilledStatus();
        state = state.copyWith(
            isLoading: false, questionsFilledStatus: filledStatus);
      }
    }
  }

  Future<void> updateBookmark(List<Question> questions, int bookmarked) async {
    try {
      for (var element in questions) {
        await _fullTestTable.updateBookmark(element.number, bookmarked);
      }
    } catch (e) {
      debugPrint("error: $e");
    }
  }

  Future<void> updateAnswer(int number, String answer) async {
    try {
      await _fullTestTable.updateAnswer(number, answer);
    } catch (e) {
      debugPrint("error: $e");
    }
  }

  Future<List<bool>> getQuestionsFilledStatus() async {
    try {
      final questions = await _fullTestTable.getAllAnswer();
      return questions.map((e) {
        return e?.answer.isNotEmpty ?? false;
      }).toList();
    } catch (e) {
      debugPrint("error: $e");
      return [];
    }
  }

  Future<bool> submitAnswer() async {
    state = state.copyWith(isSubmitLoading: true);
    try {
      final questions = await _fullTestTable.getAllAnswer();

      final request = questions
          .map((e) => {
                "question_id": e?.id ?? "",
                "bookmark": (e?.bookmarked ?? 0) > 0,
                "answer_user":
                    ((e?.answer)?.isNotEmpty ?? false) ? e!.answer : "-"
              })
          .toList();
      final response =
          await _fullTestApi.submitAnswer(request, state.testStatus.id);
      if (response) {
        debugPrint("success submit answer");
        return true;
      } else {
        debugPrint("failed submit answer");
        return false;
      }
    } catch (e) {
      debugPrint("error: $e");
      return false;
    } finally {
      // state = state.copyWith(isSubmitLoading: false);
    }
  }

  Future<bool> resubmitAnswer() async {
    state = state.copyWith(isSubmitLoading: true);
    try {
      final questions = await _fullTestTable.getAllAnswer();

      final request = questions
          .map((e) => {
                "question_id": e?.id ?? "",
                "bookmark": (e?.bookmarked ?? 0) > 0,
                "answer_user":
                    ((e?.answer)?.isNotEmpty ?? false) ? e!.answer : "-"
              })
          .toList();
      final response =
          await _fullTestApi.resubmitAnswer(request, state.testStatus.id);
      if (response) {
        debugPrint("success submit answer");
        return true;
      } else {
        debugPrint("failed submit answer");
        return false;
      }
    } catch (e) {
      debugPrint("error: $e");
      return false;
    } finally {
      // state = state.copyWith(isSubmitLoading: false);
    }
  }

  Future<bool> resetAll() async {
    state = state.copyWith(isSubmitLoading: true);
    try {
      await resetPacketTable();
      await resetTestStatus();
      return true;
    } catch (e) {
      return false;
    } finally {
      await Future.delayed(const Duration(seconds: 4));
      state = state.copyWith(isSubmitLoading: false);
    }
  }

  void resetState() {
    state = FullTestProviderState(
      packetDetail: PacketDetail(id: '', name: '', questions: []),
      selectedQuestions: [],
      isLoading: true,
      isSubmitLoading: false,
      questionsFilledStatus: [],
      testStatus:
          TestStatus(id: '', startTime: '', resetTable: false, name: ''),
    );
  }
}

final fullTestProvider =
    StateNotifierProvider<FullTestProvider, FullTestProviderState>((ref) {
  final provider = FullTestProvider();
  ref.onDispose(() {
    debugPrint("dispose full test provider");
    provider.resetState();
  });

  return provider;
});
