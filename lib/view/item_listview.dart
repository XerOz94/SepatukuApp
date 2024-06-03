// item_user.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepatuku_app/model/data.dart';
import '../viewmodel/detail_page.dart';

class ItemUser extends StatelessWidget {
  final int index;
  final SepatuModel data;

  ItemUser(this.index, this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white, // Menambahkan bayangan pada card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.black, width: 1.0),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(data),
            ),
          );
        },
        child: Container(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  data.image,
                  fit: BoxFit.cover,
                  width: 220,
                  height: 220,
                  alignment: Alignment.topCenter, // Geser ke atas
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.blue.withOpacity(1),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Text(
                  data.name,
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                   color: Colors.black,
                  //  color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                  maxLines: 2, // Membatasi menjadi 2 baris
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.raleway(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),  
                    SizedBox(height: 4),
                    Text(
                      'Harga: ${data.price}',
                      style: GoogleFonts.raleway(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}