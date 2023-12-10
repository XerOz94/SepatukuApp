// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'data.dart';

class DetailPage extends StatefulWidget {
  final SepatuModel data;

  DetailPage(this.data);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _selectedTabIndex = 0;

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
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
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
                  child: Text('Review'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Tampilkan informasi sepatu
                    setState(() {
                      _selectedTabIndex = 1;
                    });
                  },
                  child: Text('Shoe Info'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Tampilkan link produk
                    setState(() {
                      _selectedTabIndex = 2;
                    });
                  },
                  child: Text('Shop'),
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
                                color: Colors.white, fontSize: 16,),
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
}
