class Quiz {
  final String? question;
  Map<String, bool>? answers;

  Quiz({this.question, this.answers});

  static Quiz fromJson(Map<dynamic, dynamic> json) {
    final question = json["question_text"];
    Map<String, bool> answers = {};
    for (var answer in json["answers"]) {
      answers[answer["answer_text"]] = answer["is_correct"];
    }
    return Quiz(question: question, answers: answers);
  }
}