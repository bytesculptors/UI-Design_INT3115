class Quiz {
  final String question;
  final Map<String, bool> answers;
  String choosenAnswer = "";

  Quiz({required this.question, required this.answers});

  bool checkAnswer() {
    if (choosenAnswer == "") {
      return false;
    } else {
      return answers[choosenAnswer]!;
    }
  }

  static Quiz fromJson(Map<dynamic, dynamic> json) {
    final question = json["question_text"];
    Map<String, bool> answers = {};
    for (var answer in json["answers"]) {
      answers[answer["answer_text"]] = answer["is_correct"];
    }

    return Quiz(question: question, answers: answers);
  }
}
