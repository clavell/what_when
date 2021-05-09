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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'What When',
      theme: ThemeData.dark().copyWith(
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Color(0xFF22292E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
        ),
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
        textTheme: GoogleFonts.montserratAlternatesTextTheme(
          Theme.of(context).textTheme.copyWith(
                bodyText1: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, fontSize: 16),
              ),
        ),
      ),
      home: TaskListScreen(),
    );
  }
}
