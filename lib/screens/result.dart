import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quiz_master/models/cqmodel.dart';
import 'package:quiz_master/providers/quizprovider.dart';

class ResultScreen extends StatelessWidget {
  final CategoryModel category;

  const ResultScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final score = quizProvider.calculateScore(category);

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Result"),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text("Total Questions: 5", style: TextStyle(fontSize: 24),),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Correct Answers : ",
                    style: TextStyle(fontSize: 24,color: Theme.of(context)
              .colorScheme
              .onSurface, ),
                  ),
                  TextSpan(
                    text: "$score",
                    style: TextStyle(fontSize: 24, color: Colors.green),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Wrong Answers : ",
                    style: TextStyle(fontSize: 24,color: Theme.of(context)
              .colorScheme
              .onSurface, ),
                  ),
                  TextSpan(
                    text: "${category.questions.length-score}",
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Text("Final Score", style: TextStyle(fontSize: 24)),

            Text(
              "$score / ${category.questions.length}",
              style: TextStyle(
                fontSize: 24,
                color: Colors.pinkAccent,
                fontWeight: FontWeight.bold,
              ),
            ),

            

                 
                    Text("Percentage: ${((score*100)/category.questions.length).toInt()}%",
                    style: TextStyle(fontSize: 24 ),)
             ,

            SizedBox(height: 19),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.pinkAccent,
                ),
                onPressed: () {
                  context.read<QuizProvider>().resetQuiz();
                  context.go("/question", extra: category.triviaCategory);
                },
                child: Text("Play Again", style: TextStyle(fontSize: 24)),
              ),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.pinkAccent,
                ),
                onPressed: () {
                  context.read<QuizProvider>().resetQuiz();
                  context.go("/");
                },
                child: Text("Back to home", 
                style: TextStyle(fontSize: 24, 
                )),
              ),
            
          ],
        ),
      ),
    );
  }
}
