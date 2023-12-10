import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class AnimatedImages extends StatefulWidget {
  @override
  _AnimatedImagesState createState() => _AnimatedImagesState();
}

class _AnimatedImagesState extends State<AnimatedImages> {
  int activeIndex = 0;
  late Timer _timer;

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
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        activeIndex++;
        if (activeIndex == 3) activeIndex = 0;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Hentikan timer saat widget dihapus
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        height: 250,
        child: Stack(
          children: _imagePaths.asMap().entries.map((e) {
            return Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: activeIndex == e.key ? 1 : 0,
                child: Image.asset(e.value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
