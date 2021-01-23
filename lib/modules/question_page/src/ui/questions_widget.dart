import 'package:flutter/material.dart';
import 'package:web_test/models/questions_data_model.dart';
import 'package:web_test/modules/home_page/src/bloc/home_page_bloc.dart';
import 'package:web_test/modules/question_page/src/bloc/questions_bloc.dart';
import 'package:web_test/utilities/custom_icon_check.dart';
import 'package:web_test/utilities/globals.dart';

class QuestionsPage extends StatefulWidget {
  final QuestionDataModel model;
  final int index;
  final HomePageBloc bloc;

  const QuestionsPage(
      {Key key, @required this.model, this.index = 0, @required this.bloc})
      : super(key: key);
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  QuestionsPageBloc _bloc;
  @override
  void initState() {
    _bloc = QuestionsPageBloc();
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget _buildItemBlockQuestion() {
    if (widget.model == null || widget.model.id == null) return Container();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildItemQuestion(widget.model.question),
        Container(
          height: Globals.minPadding,
        )
      ]..addAll(widget.model.answers
          .asMap()
          .map((key, value) => MapEntry(
              key, _buildItemAnswer(value, key, widget.model.answers.length)))
          .values
          .toList()),
    );
  }

  Widget _buildItemQuestion(String question) {
    if (question == null) return Container();
    return Container(
        padding: EdgeInsets.all(Globals.minPadding),
        decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Colors.blue)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                question,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            )
          ],
        ));
  }

  Widget _buildItemAnswer(Answers answer, int index, int length) {
    if (answer == null || answer.id == null) return Container();
    return Container(
      padding: EdgeInsets.all(Globals.minPadding),
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular((index == length - 1) ? 8 : 0),
              topRight: Radius.circular((index == 0) ? 8 : 0),
              bottomLeft: Radius.circular((index == length - 1) ? 8 : 0),
              topLeft: Radius.circular((index == 0) ? 8 : 0))),
      child: InkWell(
        onTap: (){
          widget.bloc.selectAnswer(answer, widget.model);
        },
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomIconCheck(
              isSelected: answer.isSelected,
              width: 40.0,
              height: 40.0,
            ),
            Container(
              width: Globals.minPadding,
            ),
            Expanded(
              child: Text(
                answer.content ?? "",
                style: TextStyle(
                    color: answer.isSelected ? Colors.blue : Colors.black,
                    fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      height: Globals.maxHeight,
      width: Globals.maxWidth,
      margin: EdgeInsets.all(Globals.maxPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: Globals.maxPadding*6,
            padding: EdgeInsets.all(Globals.minPadding),
            margin: EdgeInsets.only(bottom: Globals.minPadding),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Colors.blue)),
            child: Text(
              "Question ${widget.index} of ${widget.bloc.length ?? 0}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          _buildItemBlockQuestion()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
