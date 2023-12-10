import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepatuku_app/SepatukuPage.dart';
import 'package:sepatuku_app/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SepatuKu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.raleway().fontFamily,
      ),
      home:  HomePage(),
      routes: {
        '/listview': (context) => SepatukuPage(title: 'Galeri Sepatu'),
      },
    );
  }
}
