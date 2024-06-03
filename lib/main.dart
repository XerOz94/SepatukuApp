import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepatuku_app/view/OnBoardingPage.dart';
import 'package:sepatuku_app/provider/theme_provider.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SepatuKu',
        themeMode: themeProvider.themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: HomePage(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ),
            child: child!,
          );
        },
      );
    },
  );
}