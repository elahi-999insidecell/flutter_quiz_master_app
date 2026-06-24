import 'package:flutter/material.dart';
import 'package:quiz_master/api/api_services.dart';
import 'package:quiz_master/api/endpoints.dart';
import 'package:quiz_master/models/categorymodel.dart';
import 'package:quiz_master/models/cqmodel.dart';

class QuizProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<TriviaCategory> categories = [];
  bool isLoading = false;
  String? errorMesg;

  Future<void> fetchCategories() async {
    isLoading = true;
    errorMesg = null;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.openTdbCategoryUrl);
      if (response.statusCode == 200) {
        final categoryResponse = CategoryResponseModel.fromJson(response.data);
        categories = categoryResponse.triviaCategories ?? [];
      } else {
        errorMesg = "Failed to load API";
      }
    } catch (e) {
      errorMesg = "Failed to load categories : $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //
  Future<List<QuestionModel>> fetchQuestions(int category, int amount) async {
    //duita params amount and category

    try {
      final response = await _apiService.get(
        ApiEndpoints.openTdbquestionUrl,
        queryParameters: {"category": category, "amount": amount},
      );

      if (response.statusCode == 200) {
        final List results = response.data["results"];
        return results.map((data) {
          final String question = data['question'];
          final String corrans = data["correct_answer"];
          final List<String> incorrans = List<String>.from(
            data["incorrect_answers"],
          );
          List<String> options = List<String>.from(incorrans);
          options.add(corrans);
          final int corrAnsIndex = options.indexOf(corrans);
          return QuestionModel(
            whatQ: question,
            options: options,
            answer: corrAnsIndex,
          );
        }).toList();
      } else {
        throw Exception("Failed to load questions");
      }
    } catch (e) {
      throw Exception("Error Fetching questions");
    }
  }

 

  Map<int, int> selectedOptions = {};
  void selectedOpt(int questionIndex, int optionIndex) {
    selectedOptions[questionIndex] = optionIndex;
    notifyListeners();
  }

  //result

  int calculateScore(CategoryModel category) {
    int score = 0;
    for (int i = 0; i < category.questions.length; i++) {
      if (selectedOptions[i] == category.questions[i].answer) {
        score++;
      }
    }
    return score;
  }

  //reset

  void resetQuiz() {
    selectedOptions.clear();
    notifyListeners();
  }
}
