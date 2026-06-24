import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quiz_master/models/categorymodel.dart';

import 'package:quiz_master/models/cqmodel.dart';

import 'package:quiz_master/providers/quizprovider.dart';

import 'package:quiz_master/providers/thema.dart';
import 'package:quiz_master/screens/home.dart';
import 'package:quiz_master/screens/question.dart';
import 'package:quiz_master/screens/result.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themprovider = Thema();
  await themprovider.loadTheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themprovider),
        ChangeNotifierProvider(
          create: (_) => QuizProvider()..fetchCategories(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeprovider = context.watch<Thema>();
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeprovider.isDark ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}

//go router

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => Home()),
    GoRoute(
      path: '/question',
      builder: (context, state) {
        final category = state.extra as TriviaCategory;
        return QuestionScreen(category: category);
      },
    ),

    GoRoute(
      path: "/result",
      builder: (context, state) {
        final category = state.extra as CategoryModel;
        return ResultScreen(category: category);
      },
    ),
  ],
);
