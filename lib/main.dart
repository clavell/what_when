import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:what_when/model/task_list_model.dart';
import 'package:what_when/screen/task_list_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TaskListModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        textTheme: GoogleFonts.solwayTextTheme(
          Theme.of(context).textTheme,
        ),
      ),

      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: TaskListScreen(),
    );
  }
}
