import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_test/common/constant.dart';
import 'package:web_test/models/questions_data_model.dart';
import 'package:web_test/modules/home_page/src/bloc/home_page_bloc.dart';
import 'package:web_test/modules/question_page/src/ui/questions_widget.dart';
import 'package:web_test/utilities/check_platform.dart';
import 'package:web_test/utilities/custom_alert_dialog.dart';
import 'package:web_test/utilities/globals.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc _bloc;
  @override
  void initState() {
    _bloc = HomePageBloc();
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.loadJson();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Globals().init(context: context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: _bloc.outputListQuestions,
          initialData: List<QuestionDataModel>(),
          builder: (_, snapshot) {
            if (snapshot.data == null) return Container();
            List<QuestionDataModel> _listQuestion = snapshot.data;
            if (_listQuestion == null || _listQuestion.length == 0)
              return Container();
            return Container(
              child: StreamBuilder(
                  stream: _bloc.outputQuestions,
                  builder: (_, snap) {
                    if (snap.data == null) return Container();
                    QuestionDataModel _question = snap.data;
                    int index = 0;
                    for (int i = 0; i < _listQuestion.length; i++) {
                      if (_question.id == _listQuestion[i].id) {
                        index = i;
                        break;
                      }
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: ListView(
                            physics: ClampingScrollPhysics(),
                            children: [
                              QuestionsPage(
                                bloc: _bloc,
                                model: _question,
                                index: index + 1,
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: index == _bloc.length - 1
                                  ? Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            int result = 0;
                                            bool isCompleted = true;
                                            for (int i = 0;
                                                i <= _listQuestion.length - 1;
                                                i++) {
                                              if (_listQuestion[i].answer ==
                                                  null) {
                                                isCompleted = false;
                                                break;
                                              }
                                              int a = int.parse(_listQuestion[i]
                                                  .answer
                                                  .trim());
                                              if (a == 1) {
                                                result += 1;
                                              }
                                            }
                                            if (!isCompleted) {
                                              showCustomAlertDialog(
                                                  context,
                                                  "Thông báo",
                                                  "Bạn chưa chọn hết đáp án, vui lòng kiểm tra lại!",
                                                cancelable: false,);
                                            } else {
                                              showCustomAlertDialog(
                                                  context,
                                                  "Chúc mừng!",
                                                  "Bạn đã trả lời chính xác $result đáp án!",
                                                  cancelable: false,
                                                  buttonLeft: CustomOptionDialog("",Colors.transparent,(){},Colors.transparent));
                                            }
                                          },
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          child: Container(
                                            width: Globals.maxPadding * 6,
                                            padding: EdgeInsets.all(
                                                Globals.minPadding),
                                            margin: EdgeInsets.only(
                                                bottom: Globals.maxPadding,
                                                left: Globals.maxPadding),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                border: Border.all(
                                                    color: Colors.blue)),
                                            child: Text(
                                              "Submit",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                      ],
                                    )
                                  : Container(),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: Globals.maxPadding,
                                  right: Globals.maxPadding),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (index == 0) {
                                        return;
                                      }
                                      _bloc.changeQuestion(index - 1);
                                    },
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: index == 0
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                right: Globals.maxPadding),
                                            alignment: Alignment.center,
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(
                                                right: Globals.maxPadding),
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              "assets/icon-previous.png",
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (index == _bloc.length) {
                                        return;
                                      }
                                      _bloc.changeQuestion(index + 1);
                                    },
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: Globals.maxPadding),
                                      alignment: Alignment.center,
                                      child: index == _bloc.length-1
                                          ? Container(width: 40, height: 40)
                                          : Image.asset(
                                              "assets/icon-next.png",
                                              width: 40,
                                              height: 40,
                                            ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  }),
            );
          }),
    );
  }
}
