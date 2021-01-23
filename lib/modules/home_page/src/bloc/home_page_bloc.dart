import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_test/common/constant.dart';
import 'package:web_test/models/questions_data_model.dart';
import 'package:web_test/utilities/base_bloc.dart';
import 'package:web_test/utilities/globals.dart';

class HomePageBloc extends BaseBloc{

  final _streamQuestions = BehaviorSubject<QuestionDataModel>();
  final _streamListQuestions = BehaviorSubject<List<QuestionDataModel>>();
  int _length =0;
  int get length => _length;
  Stream<List<QuestionDataModel>> get outputListQuestions => _streamListQuestions.stream;
  Stream<QuestionDataModel> get outputQuestions => _streamQuestions.stream;
  List<QuestionDataModel> _listQuestionsRandom=new  List<QuestionDataModel>();
  setListQuestions(List<QuestionDataModel> event) => _streamListQuestions.sink.add(event);
  setQuestions(QuestionDataModel event) => _streamQuestions.sink.add(event);
  @override
  void dispose() {
    // TODO: implement dispose
    _streamListQuestions.close();
    _streamQuestions.close();
    super.dispose();
  }
  List<QuestionDataModel> _listQuestionsData;
  loadJson() async {
    String data = await rootBundle.loadString('test_questions.json');
    dynamic jsonResult = json.decode(data);
    if(jsonResult!=null){
      _listQuestionsData = new  List<QuestionDataModel>();
      if(jsonResult is List){
        jsonResult.forEach((element) {
          _listQuestionsData.add(QuestionDataModel.fromJson(element));
        });
      }
      bool random = false;
      if(_listQuestionsData.length>0){
        var rng = new Random();
        if(Globals.prefs==null){
          Globals.prefs = await SharedPreferences.getInstance();
         random =  Globals.prefs.getBool(randomKey)??false;
        }
        print(random);
        if(!random){
          for (var i = 0; i < _listQuestionsData.length/2; i++) {
            _listQuestionsRandom.add(_listQuestionsData[i]);
            // _listQuestionsRandom.add(_listQuestionsData[rng.nextInt(_listQuestionsData.length)]);
            print(_listQuestionsRandom.last.id);
          }
        }
        setListQuestions(_listQuestionsRandom);
        _length = _listQuestionsRandom.length;
        setQuestions(_listQuestionsRandom[0]);
      }
    }
  }
  selectAnswer(Answers answer, QuestionDataModel question){
    try {
      List<Answers> _list = List<Answers>();
      _list.addAll(question.answers);
      for (int i = 0; i < _list.length; i++) {
        _list[i].isSelected = false;
      }
      int index = _list.indexOf(_list.firstWhere((element) => element.id == answer.id));
      if (index != null){
        _list[index].isSelected = true;
        QuestionDataModel _temp = question;
        _temp.answers = _list;
        _temp.answer= _list[index].id.toString();
        List<QuestionDataModel> _listQuestion = _streamListQuestions.stream.value;
        int indexQuestion = _listQuestion.indexOf(_listQuestion.firstWhere((element) => element.id == _temp.id));
        if(indexQuestion!=null){
          _listQuestion[indexQuestion] = _temp;
          setListQuestions(_listQuestion);
        }
      }
    } catch (e) {
      print('error:'+ e.toString());
    }
  }
  changeQuestion(int index){
    try {
      List<QuestionDataModel> _listQuestion = _streamListQuestions.stream.value;
      if(index!=null){
        setListQuestions(_listQuestion);
        setQuestions(_listQuestion[index]);
      }
    } catch (e) {
      print('error:'+ e.toString());
    }
  }
}