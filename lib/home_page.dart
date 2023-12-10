import 'dart:async';
import 'dart:math' as math;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepatuku_app/login.dart';
import 'package:sepatuku_app/register.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int activeIndex = 0;

  final List<String> _images = [
    'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_400,h_400/global/374902/01/sv01/fnd/IND/fmt/png/PUMA-Serve-Pro-Lite-Unisex-Shoes',
    'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_400,h_400/global/380697/03/sv01/fnd/IND/fmt/png/Wild-Rider-Layers-Unisex-Sneakers',
    'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_400,h_400/global/371149/68/sv01/fnd/IND/fmt/png/Future-Rider-Play-On-Unisex-Sneakers'
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
              FadeInUp(
                child: Container(
                  height: 320,
                  child: Stack(
                    children: _images.asMap().entries.map((e) {
                      return Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: AnimatedOpacity(
                          duration: Duration(seconds: 1),
                          opacity: activeIndex == e.key ? 1 : 0,
                          child: Transform.rotate(
                            angle: -math.pi / 12, // 15 degrees in radians
                            child: Image.network(
                              e.value,
                              height: 100,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sepatu',
                    style: GoogleFonts.raleway(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Ku',
                    style: GoogleFonts.raleway(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                "Sepatuku App merupakan sebuah aplikasi review sepatu, yang berisi artikel-artikel seputar sepatu masa kini.",
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
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: const Text(
                    "Getting Started",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                const SizedBox(width: 4.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text(
                    "Login.",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}
