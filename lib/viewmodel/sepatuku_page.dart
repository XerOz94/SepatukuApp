import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepatuku_app/view/MaintancePage.dart';
import 'package:sepatuku_app/view/favourite_page.dart';
import 'package:sepatuku_app/viewmodel/produk_terbaru.dart';
import 'package:sepatuku_app/view/bottomNavbar.dart';
import 'package:sepatuku_app/provider/change_theme_widget.dart';
import 'package:sepatuku_app/view/item_listview.dart';
import 'package:sepatuku_app/viewmodel/profile_page.dart';
import 'package:sepatuku_app/model/data.dart';
import 'package:sepatuku_app/services/api_service.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SepatukuPage extends StatefulWidget {
  const SepatukuPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SepatukuPage> createState() => _SepatukuPageState();
}

class _SepatukuPageState extends State<SepatukuPage> {
  int _currentPageIndex = 0;
  late Future<List<SepatuModel>> _dataFuture; // Inisialisasi _produkListFuture
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _dataFuture = ApiService().getData(); // Ganti dengan metode API yang sesuai
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
            icon: Icon(Icons.stacked_line_chart, color: Colors.blue),
            onPressed: () {},
          ),
          actions: [ChangeThemeButtonWidget()],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Hot Shoes 🔥",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder<List<SepatuModel>>(
                future: _dataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: 5,
                          itemBuilder:
                              (BuildContext context, int index, int realIndex) {
                            return ProdukTerbaru(index, snapshot.data![index]);
                          },
                          options: CarouselOptions(
                            aspectRatio: 16 / 8,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),
                        ),
                        // Sesuaikan jarak antara slider dan indikator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                            // snapshot.data!.length,
                            (index) => buildIndicator(index, 5),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Recently Post 💣",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder<List<SepatuModel>>(
                future: _dataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context)
                            .primaryColor, // Gunakan warna aksen berdasarkan tema
                      ),
                    ));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              2, // Menampilkan dua item dalam satu baris
                          crossAxisSpacing: 8.0, // Spasi antar kolom
                          mainAxisSpacing: 8.0, // Spasi antar baris
                          childAspectRatio: 5 / 6),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final dataIndex = index;
                        return ItemUser(dataIndex, snapshot.data![dataIndex]);
                      },
                    );
                  }
                },
              ),
            ],
          ),
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

  Widget buildIndicator(int index, int length) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == currentIndex % 5 ? Colors.blue : Colors.grey.shade300,
      ),
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
      return FavouritePage();
    case 2:
      return ProfilePage();
    default:
      return Container(); // Halaman default atau placeholder
  }
}
