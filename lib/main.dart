  import 'package:firebase_core/firebase_core.dart';
  import 'package:flutter/material.dart';
  import 'package:sepatuku_app/app.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        appId: '1:191481072680:android:6b32b89f6ee16fe70c791d',
        apiKey: 'AIzaSyCjbO_eaaXzRL52QOlD9MDwFKIRz8RXylQ',
        messagingSenderId: '191481072680',
        projectId: 'sepatukuapp',
      ),

    );

    runApp(const MyApp());
  }
