import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepatuku_app/view/OnBoardingPage.dart';
import 'package:sepatuku_app/provider/theme_provider.dart';
import 'package:sepatuku_app/view/favourite_page.dart';
import 'package:sepatuku_app/view/login.dart';
import 'package:sepatuku_app/view/register.dart';
import 'package:sepatuku_app/viewmodel/profile.dart';
import 'package:sepatuku_app/viewmodel/sepatuku_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
   final bool isLoggedIn;
  const MyApp({required this.isLoggedIn});

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
            initialRoute: '/home',
            routes: {
              '/home': (context) => HomePage(),
              '/login': (context) => Login(),
              '/register': (context) => Register(),
              '/sepatuku_page': (context) => SepatukuPage(
                    title: "SepatuKu",
                  ),
              '/profile': (context) => ProfilePage(),
              '/favourite': (context) => FavouritePage(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/login') {
                return MaterialPageRoute(builder: (context) => Login());
              }
              // Tambahkan penanganan rute lainnya jika diperlukan
              return null;
            },
          );
        },
      );
}
