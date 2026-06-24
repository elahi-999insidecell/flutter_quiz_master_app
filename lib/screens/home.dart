// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quiz_master/providers/quizprovider.dart';
import 'package:quiz_master/providers/thema.dart';
import 'package:quiz_master/utils/category_icon.dart';
import 'package:quiz_master/utils/categorycard.dart';
import 'package:quiz_master/utils/sharedpref.dart';
import 'package:quiz_master/widgets/stats.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Sharedpref sharedPref = Sharedpref();

  int totalAttempts = 0;
  int highestScore = 0;
  int lastScore = 0;

  List<String> history = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final stats = await sharedPref.LoadStats();
    final historyData = await sharedPref.loadHistory();

    setState(() {
      totalAttempts = stats['totalAttempts']!;
      highestScore = stats['highestScore']!;
      lastScore = stats['lastScore']!;
      history = historyData;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    final themeprovider = context.read<Thema>();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Quiz Master"),
            IconButton(
              onPressed: () {
                themeprovider.toggleThema(!themeprovider.isDark);
              },
              icon: themeprovider.isDark
                  ? Icon(Icons.light_mode)
                  : Icon(Icons.dark_mode),
            ),
          ],
        ),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Welcome to Quiz Master!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Test your knowledge and improve your learning skills",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
              SizedBox(height: 20),

              Text(
                "Statistics for you:",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    statItem(Icons.quiz, totalAttempts.toString(), "Attempts"),
                    statItem(
                      Icons.emoji_events,
                      "$highestScore/5",
                      "Highest Score",
                    ),
                    statItem(Icons.history, "$lastScore/5", "Last Score"),
                  ],
                ),
              ),
              SizedBox(height: 30),
              const SizedBox(height: 20),

const Text(
  "Quiz History",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 10),
history.isEmpty
    ? const Text(
        "No quiz played yet",
      )
    : ListView.builder(
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.history,
                color: Colors.pinkAccent,
              ),
              title: Text(
                history[index],
              ),
            ),
          );
        },
      ),

              Text(
                "Categories:",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              //Quiz Section
              Consumer<QuizProvider>(
                builder: (context, quizProvider, child) {
                  ///adding
                  final categories = quizProvider.categories;
                  //loading shotto hoy+ category null hoy, tahole ghurte thakbe
                  //1.error
                  if (quizProvider.isLoading && categories.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }
                  //2.error
                  if (quizProvider.errorMesg != null && categories.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            quizProvider.errorMesg!,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () => quizProvider.fetchCategories(),
                            child: Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  }

                  //3. error empty state

                  if (categories.isEmpty) {
                    return Center(
                      child: Text(
                        "no categories found",

                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  //4. data state (using triviacategory from response model)

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final callTheDatabase = categories[index];
                      return CategoryCard(
                        title: categories[index].name ?? '',

                        subtitle: "Total Questions: 5",
                        icon: getCategoryIcon(callTheDatabase.id!),
                        click: () {
                          context.push("/question", extra: callTheDatabase);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
