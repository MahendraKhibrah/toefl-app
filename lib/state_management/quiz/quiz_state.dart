
// import 'package:freezed_annotation/freezed_annotation.dart';

// part '../quiz_state.freezed.dart';

// ///
// /// It is defined using `freezed` and `json_serializable`.
// @freezed
// class QuizState with _$QuizState {
//   factory QuizState({
//     required String key,
//     required String QuizState,
//     required String type,
//     required int participants,
//     required double price,
//   }) = _QuizState;

//   /// Convert a JSON object into an [QuizState] instance.
//   /// This enables type-safe reading of the API response.
//   factory QuizState.fromJson(Map<String, dynamic> json) => _$QuizStateFromJson(json);
// }

// @riverpod
// Future<Activity> activity(ActivityRef ref) async {
//   // Using package:http, we fetch a random activity from the Bored API.
//   final response = await http.get(Uri.https('boredapi.com', '/api/activity'));
//   // Using dart:convert, we then decode the JSON payload into a Map data structure.
//   final json = jsonDecode(response.body) as Map<String, dynamic>;
//   // Finally, we convert the Map into an Activity instance.
//   return Activity.fromJson(json);
// }