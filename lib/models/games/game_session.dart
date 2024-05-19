class QuizGameSession {
  int? id;
  String quizGameClaimId;
  bool isCompleted;

  QuizGameSession(
      {this.id, required this.quizGameClaimId, required this.isCompleted});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quiz_game_claim_id': quizGameClaimId,
      'is_completed': isCompleted ? 1 : 0,
    };
  }

  static QuizGameSession fromMap(Map<String, dynamic> map) {
    return QuizGameSession(
      id: map['id'],
      quizGameClaimId: map['quiz_game_claim_id'],
      isCompleted: map['is_completed'] == 1 ? true : false,
    );
  }
}

class QuizDetailAnswer {
  int? id;
  String quizGameId;
  String optionsId;
  bool isTrue;

  QuizDetailAnswer(
      {this.id,
      required this.quizGameId,
      required this.optionsId,
      required this.isTrue});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quiz_game_id': quizGameId,
      'options_id': optionsId,
      'is_true': isTrue ? 1 : 0,
    };
  }

  static QuizDetailAnswer fromMap(Map<String, dynamic> map) {
    return QuizDetailAnswer(
      id: map['id'],
      quizGameId: map['quiz_game_id'],
      optionsId: map['options_id'],
      isTrue: map['is_true'] == 1 ? true : false,
    );
  }
}
