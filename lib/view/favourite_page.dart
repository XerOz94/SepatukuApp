import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepatuku_app/model/data.dart';
import 'package:sepatuku_app/services/database_helper.dart';
import 'package:sepatuku_app/view/bottomNavbar.dart';
import 'package:sepatuku_app/viewmodel/profile_page.dart';
import 'package:sepatuku_app/viewmodel/sepatuku_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class FavouritePage extends StatefulWidget {
  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  int _currentPageIndex = 1;
  late Future<List<SepatuModel>> _favoritesFuture;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _favoritesFuture = DatabaseHelper.getFavorites().then((favorites) {
      return favorites
          .map((favorite) => SepatuModel.fromJson(favorite))
          .toList();
    });
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializeNotifications();
  }

  void initializeNotifications() {
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Favorite Status',
      message,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('My Favs',
                  style: GoogleFonts.raleway(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              Text(' Shoes',
                  style: GoogleFonts.raleway(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
             Navigator.pushNamed(context, '/sepatuku_page');
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder<List<SepatuModel>>(
          future: _favoritesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final favorites = snapshot.data!;
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final sepatu = favorites[index];
                  return ListTile(
                    leading: Image.network(sepatu.image),
                    title: Text(sepatu.name),
                    subtitle: Text(sepatu.description, maxLines: 2),
                    trailing: IconButton(
                      onPressed: () {
                        // Panggil metode deleteFavorite dari DatabaseHelper
                        DatabaseHelper.deleteFavorite(sepatu.id).then((_) {
                          // Tampilkan notifikasi setelah item dihapus
                          showNotification('${sepatu.name} removed from favorites');
                          // Setelah item dihapus dari database, perbarui tampilan
                          setState(() {
                            // Hapus item dari daftar favorit yang ditampilkan
                            favorites.removeAt(index);
                          });
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
              );
            }
          },
        ),
        bottomNavigationBar: BotNavbar(
            currentIndex: _currentPageIndex,
            onTap: (index) {
              // Panggil Navigator untuk pindah halaman berdasarkan indeks
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => _buildPage(index),
                ),
              );
            }));
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return SepatukuPage(
          title: 'Sepatuku',
        );
      case 1:
        return FavouritePage();
      case 2:
        return ProfilePage();
      default:
        return Container(); // Halaman default atau placeholder
    }
  }
}