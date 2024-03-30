import 'package:flutter/material.dart';
import 'package:loan_manager/models/loan_model.dart';
import 'package:loan_manager/models/theme_model.dart';
import 'package:loan_manager/pages/home_page.dart';
import 'package:loan_manager/themes/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoanModel()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),

      // TODO: add button to toggle dark and light mode
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}

/* 
 - add each loan to the list

 - open each entry in new page with the paid made by borrower

 - search persons name in dashboard

 - show total in dashboard

 - Add archives maybe for history to track

*/