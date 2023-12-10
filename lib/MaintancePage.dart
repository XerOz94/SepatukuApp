import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepatuku_app/AnimatedImages.dart';
import 'package:sepatuku_app/SepatukuPage.dart';
import 'package:sepatuku_app/bottomNavbar.dart';
import 'package:sepatuku_app/login.dart';
import 'package:sepatuku_app/profile_page.dart';
import 'package:sepatuku_app/register.dart';

class MaintancePage extends StatefulWidget {
  @override
  _MaintancePage createState() => _MaintancePage();
}

class _MaintancePage extends State<MaintancePage> {
  int activeIndex = 0;
  int _currentPageIndex = 1;

  final List<String> _imagePaths = [
    'assets/images/mt1.png',
    'assets/images/mt2.png',
    'assets/images/mt3.png',
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        activeIndex++;
        if (activeIndex == 3) activeIndex = 0;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sepatu',
                  style: GoogleFonts.raleway(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              Text('Ku',
                  style: GoogleFonts.raleway(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.stacked_line_chart, color: Colors.blue),
            onPressed: () {},
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ));
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                AnimatedImages(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Uh-oh!',
                  style: GoogleFonts.raleway(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Page not found',
                  style: GoogleFonts.raleway(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 50),
                SizedBox(
                  height: 45,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SepatukuPage(title: "Sepatuku Page",)));
                    },
                    child: const Text(
                      "Back to home",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: BotNavbar(
        //     currentIndex: _currentPageIndex,
        //     onTap: (index) {
        //       // Panggil Navigator untuk pindah halaman berdasarkan indeks
        //       Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(
        //           builder: (context) => _buildPage(index),
        //         ),
        //       );
        //     })
            );
  }
}

Widget _buildPage(int index) {
  switch (index) {
    case 0:
      return SepatukuPage(
        title: 'Sepatuku',
      );
    case 1:
      return MaintancePage();
    case 2:
      return ProfilePage();
    default:
      return Container(); // Halaman default atau placeholder
  }
}
