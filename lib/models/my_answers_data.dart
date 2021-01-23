class MyAnswer {
  int id;
  String content;
  String correctAnswers;
  String answer;
  MyAnswer({this.id, this.content,this.correctAnswers,this.answer});

  MyAnswer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    correctAnswers = json['correct_answers'];
    if (json['answer'] != null) {
      answer =json['answer'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    return data;
  }
}