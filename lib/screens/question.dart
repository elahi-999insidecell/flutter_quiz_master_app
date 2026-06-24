// ignore_for_file: use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quiz_master/models/categorymodel.dart';

import 'package:quiz_master/models/cqmodel.dart';
import 'package:quiz_master/providers/quizprovider.dart';
import 'package:quiz_master/utils/sharedpref.dart';

class QuestionScreen extends StatefulWidget {
  final TriviaCategory category;

  const QuestionScreen({
    super.key,
    required this.category,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late Future<List<QuestionModel>> _questionFuture;

  int currentQuestionIndex = 0;
  

  @override
  void initState() {
    super.initState();

    _questionFuture = context.read<QuizProvider>().fetchQuestions(
      widget.category.id ?? 9,
      5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      widget.category.name ?? "",
    ),
  ),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
          
        ),

        body: FutureBuilder<List<QuestionModel>>(
          future: _questionFuture,
          builder: (context, snapshot) {
            // Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              );
            }

            // Empty
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No Questions Found",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
              );
            }

            final questions = snapshot.data!;

            final currentQuestion =
                questions[currentQuestionIndex];

            final currentCategory = CategoryModel(
              categoryName: widget.category.name ?? "Quiz",
              questions: questions,
              triviaCategory: widget.category
            );

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // Question Counter
                  Text(
                    "Question ${currentQuestionIndex + 1} of ${questions.length}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Progress Indicator
                  LinearProgressIndicator(
                    value:
                        (currentQuestionIndex + 1) /
                        questions.length,
                    minHeight: 8,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  const SizedBox(height: 20),

                  // Question Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        currentQuestion.whatQ,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // MCQ Options
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          currentQuestion.options.length,
                      itemBuilder:
                          (context, optionIndex) {
                        final isSelected =
                            quizProvider.selectedOptions[
                                    currentQuestionIndex] ==
                                optionIndex;

                        return GestureDetector(
                          onTap: () {
                            context
                                .read<QuizProvider>()
                                .selectedOpt(
                                  currentQuestionIndex,
                                  optionIndex,
                                );
                          },

                          child: Container(
                            margin:
                                const EdgeInsets.only(
                                  bottom: 12,
                                ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.pink.shade50
                                  : Colors.white,

                              border: Border.all(
                                color: isSelected
                                    ? Colors.pinkAccent
                                    : Colors.grey,
                                width: 2,
                              ),

                              borderRadius:
                                  BorderRadius.circular(
                                    12,
                                  ),
                            ),

                            child: ListTile(
                              leading: Icon(
                                isSelected
                                    ? Icons
                                          .radio_button_checked
                                    : Icons
                                          .radio_button_off,
                                color:
                                    Colors.pinkAccent,
                              ),

                              title: Text(
                                currentQuestion
                                    .options[optionIndex],
                                    style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Next / Finish Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      onPressed:
                          quizProvider.selectedOptions[
                                      currentQuestionIndex] ==
                                  null
                              ? null 
                              : () async {
                                  if (currentQuestionIndex ==
                                      questions.length -
                                          1) {

                                             final score =
      quizProvider.calculateScore(
        currentCategory,
      );

  await Sharedpref().saveStats(
    score: score,
    totalQuestions: questions.length,
    categoryName: widget.category.name?? "Quiz"
  );
                                    context.go(
                                      "/result",
                                      extra:
                                          currentCategory,
                                    );
                                  } else {
                                    setState(() {
                                      currentQuestionIndex++;
                                    });
                                  }
                                },

                      style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.pinkAccent,
                            foregroundColor:
                                Colors.white,
                          ),

                      child: Text(
                        currentQuestionIndex ==
                                questions.length - 1
                            ? "Finish"
                            : "Next",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}