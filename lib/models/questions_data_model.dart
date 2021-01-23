class QuestionDataModel {
  int id;
  String question;
  String correctAnswers;
  String answer;
  List<Answers> answers;

  QuestionDataModel({this.id, this.question, this.correctAnswers, this.answers,this.answer});

  QuestionDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    correctAnswers = json['correct_answers'];
    if (json['answers'] != null) {
      answers = new List<Answers>();
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['correct_answers'] = this.correctAnswers;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  int id;
  String content;
  bool isSelected;

  Answers({this.id, this.content});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    return data;
  }
}