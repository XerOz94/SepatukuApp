import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sepatuku_app/provider/utils.dart';
import 'package:sepatuku_app/view/MaintancePage.dart';
import 'package:sepatuku_app/view/favourite_page.dart';
import 'package:sepatuku_app/viewmodel/sepatuku_page.dart';
import 'package:sepatuku_app/view/bottomNavbar.dart';
import 'package:sepatuku_app/view/login.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:sepatuku_app/services/storage_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentPageIndex = 2;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;
  final StorageService _storageService = StorageService();

  Uint8List? _image;

  void selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      Uint8List img = await pickedFile.readAsBytes();
      setState(() {
        _image = img;
      });

      // Unggah gambar ke Firebase Storage
      String downloadURL =
          await _storageService.uploadImageToStorage(_image!, currentUser.uid);
      // Simpan URL gambar ke Firestore
      updateProfileImage(downloadURL);
    }
  }

  Future<String> uploadImageToStorage(Uint8List image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child(currentUser.uid + '.jpg');

    UploadTask uploadTask = ref.putData(image);

    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> updateProfileImage(String downloadURL) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .update({
      'image': downloadURL,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Foto profil berhasil diperbarui'),
        backgroundColor: Colors.green,
      ),
    );
  }

  TextEditingController _usernameController = TextEditingController();
  // TextEditingController _imageController = TextEditingController();
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
                  )),
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons
                .arrow_back_ios_new_rounded), // Menggunakan ikon panah kembali
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
                    _showLogoutConfirmationDialog();
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
                    _usernameController.text = userData['username'];
                    _aboutController.text = userData['about'];
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              fotoprofil != null
                                  ? CircleAvatar(
                                      radius: 80,
                                      backgroundImage: NetworkImage(fotoprofil),
                                    )
                                  : const CircleAvatar(
                                      radius: 80,
                                      backgroundImage: NetworkImage(
                                          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png"),
                                    ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors
                                        .white, // Warna background lingkaran putih
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.camera_alt,
                                        color: Colors.blue, size: 30),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Wrap(
                                            children: [
                                              ListTile(
                                                leading: Icon(Icons.photo),
                                                title: Text('Galeri'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  selectImage(
                                                      ImageSource.gallery);
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.camera),
                                                title: Text('Kamera'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  selectImage(
                                                      ImageSource.camera);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
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
                                ),
                                onPressed: () {
                                  _showEditProfileModal();
                                },
                                child: const Text(
                                  "Edit Profile",
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
                    // _imageController.text,
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

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Apakah Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                _auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
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
    // String pp,
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
        // 'image':
        //     "https://wallpapers-clan.com/wp-content/uploads/2022/08/default-pfp-" +
        //         pp +
        //         ".jpg",
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
      return FavouritePage();
    case 2:
      return ProfilePage();
    default:
      return Container(); // Halaman default atau placeholder
  }
}
