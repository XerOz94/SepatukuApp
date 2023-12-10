import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepatuku_app/MaintancePage.dart';
import 'package:sepatuku_app/SepatukuPage.dart';
import 'package:sepatuku_app/bottomNavbar.dart';
import 'package:sepatuku_app/login.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentPageIndex = 2;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  TextEditingController _fbController = TextEditingController();
  TextEditingController _igController = TextEditingController();
  TextEditingController _githubController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
              Text('Profile',
                  style: GoogleFonts.raleway(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              Text('Page',
                  style: GoogleFonts.raleway(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black87), // Menggunakan ikon panah kembali
            onPressed: () {
              Navigator.pop(
                  context); // Fungsi untuk kembali ke layar sebelumnya
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.blue,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userData =
                      snapshot.data?.data() as Map<String, dynamic>?;
                  if (userData != null) {
                    final username = userData['username'] ?? '';
                    final fotoprofil = userData['image'] ?? '';
                    final bio = userData['about'] ?? '';
                    final email = userData['email'] ?? '';
                    // Set nilai awal pada field update
                    _usernameController.text = userData['username'];
                    // _fbController.text = userData['fb'];
                    // _igController.text = userData['instagram'];
                    // _githubController.text = userData['github'];
                    // _imageController.text = userData['image'];
                    _aboutController.text = userData['about'];
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 180,
                            height: 180,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(fotoprofil),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(username,
                              style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.bold, fontSize: 30)),
                          SizedBox(height: 5),
                          Text(email!,
                              style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic)),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSocialMediaButton(
                                  icon: Icons.facebook,
                                  onPressed: () {
                                    launchUrlString(userData['fb']!);
                                  }),
                              _buildSocialMediaButton(
                                  icon: FontAwesomeIcons.instagram,
                                  onPressed: () {
                                    launchUrlString(userData['instagram']);
                                  }),
                              _buildSocialMediaButton(
                                  icon: FontAwesomeIcons.github,
                                  onPressed: () {
                                    launchUrlString(userData['github']!);
                                  }),
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 30,
                              width: 120,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () {
                                  _showEditProfileModal();
                                },
                                child: const Text(
                                  "Edit Profile",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 48),
                            child: Column(
                              children: [
                                Text(
                                  'About',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  bio,
                                  style: TextStyle(fontSize: 16, height: 1.4),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Text('Data tidak ditemukan');
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error${snapshot.error}'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
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

  void _showEditProfileModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _imageController,
                    decoration: InputDecoration(
                      labelText: 'Photo Profile',
                      prefixIcon: Icon(Icons.image),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _fbController,
                    decoration: InputDecoration(
                      labelText: 'Facebook',
                      prefixIcon: Icon(FontAwesomeIcons.facebook),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _igController,
                    decoration: InputDecoration(
                      labelText: 'Instagram',
                      prefixIcon: Icon(FontAwesomeIcons.instagram),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _githubController,
                    decoration: InputDecoration(
                      labelText: 'Github',
                      prefixIcon: Icon(FontAwesomeIcons.github),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _aboutController,
                    decoration: InputDecoration(
                      labelText: 'About',
                      prefixIcon: Icon(FontAwesomeIcons.info),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context); // Tutup dialog tanpa menyimpan perubahan
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Tutup dialog
                Future.microtask(() {
                _updateUserData(
                  _usernameController.text,
                  _fbController.text,
                  _igController.text,
                  _githubController.text,
                  _imageController.text,
                  _aboutController.text,
                );
              });
              },
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateUserData(
    String username,
    String fb,
    String ig,
    String github,
    String pp,
    String about,
  ) async {
    try {
      // Update data di Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid)
          .update({
        'username': username,
        'fb': "https://web.facebook.com/" + fb,
        'instagram': "https://web.instagram.com/" + ig,
        'github': "https://web.github.com/" + github,
        'image':
            "https://wallpapers-clan.com/wp-content/uploads/2022/08/default-pfp-" +
                pp +
                ".jpg",
        'about': about,
      });

      // Tampilkan snackbar atau pesan sukses jika diperlukan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data berhasil diperbarui'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      // Tampilkan snackbar atau pesan error jika terjadi kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // void _updateProfileData() {
  //   // Panggil _updateUserData di sini
  //   _updateUserData(
  //     _usernameController.text,
  //     _fbController.text,
  //     _igController.text,
  //     _githubController.text,
  //     _imageController.text,
  //     _aboutController.text,
  //   );
  // }
}

Widget _buildSocialMediaButton({
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget _buildPage(int index) {
  switch (index) {
    case 0:
      return SepatukuPage(
        title: 'Sepatuku',
      );
    case 1:
      return MaintancePage();
    case 2:
      return ProfilePage();
    default:
      return Container(); // Halaman default atau placeholder
  }
}
