import 'dart:math';
import 'package:stroke_text/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepatuku_app/viewmodel/detail_page.dart';
import 'package:sepatuku_app/model/data.dart';

class ProdukTerbaru extends StatelessWidget {
  final int index;
  final SepatuModel data;

  ProdukTerbaru(this.index, this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170.0,
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.black, width: 1.0),
              ),
              child: Stack(
                children: [
                  Transform.rotate(
                    angle: -15 * pi / 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        data.image,
                        fit: BoxFit.cover,
                        width: 350.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 300.0,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.blue.withOpacity(1),
                           Colors.white.withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: StrokeText(
                            text: data.name,
                            textStyle: GoogleFonts.raleway(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).textTheme.bodyText1?.color,
                            ),
                            strokeColor: Colors.blue,
                            strokeWidth: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 25,
                            width: 90,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                // backgroundColor: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(data),
                                  ),
                                );
                              },
                              child: Text(
                                "Baca",
                                style:  GoogleFonts.raleway(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
