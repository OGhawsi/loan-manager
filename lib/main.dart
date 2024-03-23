import 'package:flutter/material.dart';
import 'package:loan_manager/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: Color.fromARGB(255, 87, 87, 87),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

/* 
 - add each loan to the list

 - open each entry in new page with the paid made by borrower

 - search persons name in dashboard

 - show total in dashboard

*/