// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepatuku_app/services/database_helper.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:sepatuku_app/model/data.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class DetailPage extends StatefulWidget {
  final SepatuModel data;

  DetailPage(this.data);

  @override
  _DetailPageState createState() => _DetailPageState();
}
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class _DetailPageState extends State<DetailPage> {
  late Future<bool> _isFavoriteFuture;
  int _selectedTabIndex = 0;


  void initState() {
    super.initState();
    _isFavoriteFuture = DatabaseHelper.isFavorite(widget.data.id);

    // Konfigurasi inisialisasi notifikasi
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
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
                )),
            Text('Ku',
                style: GoogleFonts.raleway(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: toggleFavorite,
              icon: Icon(
                widget.data.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline,
                color: widget.data.isFavorite ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.data.image,
              width: 300,
              height: 300,
            ),
            SizedBox(height: 16),
            Text(
              widget.data.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Tampilkan deskripsi
                    setState(() {
                      _selectedTabIndex = 0;
                    });
                  },
                  child: Text('Review',
                      style: TextStyle()),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Tampilkan informasi sepatu
                    setState(() {
                      _selectedTabIndex = 1;
                    });
                  },
                  child: Text('Shoe Info',
                      style: TextStyle()),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Tampilkan link produk
                    setState(() {
                      _selectedTabIndex = 2;
                    });
                  },
                  child:
                      Text('Shop', style: TextStyle()),
                ),
              ],
            ),
            SizedBox(height: 16),
            _selectedTabIndex == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      elevation: 2,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.blue, Colors.lightBlue],
                          ),
                        ),
                        child: ListTile(
                          subtitle: Text(
                            widget.data.description,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : _selectedTabIndex == 1
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.count(
                          crossAxisCount: 1,
                          childAspectRatio: 4,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Card(
                              elevation: 2,
                              margin: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.blue, Colors.lightBlue],
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    'Merk',
                                    style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    widget.data.merk,
                                    style: GoogleFonts.raleway(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                  trailing: Icon(
                                    Icons.info,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 2,
                              margin: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.blue, Colors.lightBlue],
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    'Tahun',
                                    style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    widget.data.rilis,
                                    style: GoogleFonts.raleway(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                  trailing: Icon(
                                    Icons.calendar_month_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 2,
                              margin: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.blue, Colors.lightBlue],
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    'Material',
                                    style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    widget.data.material,
                                    style: GoogleFonts.raleway(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                  trailing: Icon(
                                    Icons.architecture_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            // ... widget berikutnya ...
                          ],
                        ),
                      )
                    : _selectedTabIndex == 2
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Link Produk:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: widget.data.shop,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    launchUrlString(widget.data.shop);
                                  },
                                  child: Text('Beli'),
                                ),
                              ],
                            ),
                          )
                        : Container(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void toggleFavorite() async {
    if (widget.data.isFavorite) {
      // Hapus dari favorit jika sudah ada
      await DatabaseHelper.deleteFavorite(widget.data.id);
    } else {
      // Tambahkan ke favorit jika belum ada
      await DatabaseHelper.insertFavorite({
        'id': widget.data.id,
        'name': widget.data.name,
        'image': widget.data.image,
        'description': widget.data.description,
        'price': widget.data.price,
        'merk': widget.data.merk,
        'rilis': widget.data.rilis,
        'material': widget.data.material,
        'shop': widget.data.shop,
      });
      _showNotification();
    }

    setState(() {
      widget.data.isFavorite = !widget.data.isFavorite;
    });
  }
  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'favorite_channel_id',
      'Favorite Channel',
      channelDescription: 'Channel for favorite notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'SepatuKu',
      widget.data.isFavorite
          ? 'Removed from Favorites'
          : 'Added to Favorites',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}