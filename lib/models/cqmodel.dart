import 'package:quiz_master/models/categorymodel.dart';

class CategoryModel {
  final String categoryName;
  final List<QuestionModel> questions;
 final TriviaCategory triviaCategory;
  CategoryModel({
  required this.categoryName, 
  required this.questions, 
  required this.triviaCategory});
}

class QuestionModel {
  final String whatQ;
  final List<String> options;
  final int answer;

  QuestionModel({
    required this.whatQ,
    required this.options,
    required this.answer,
  });
}
