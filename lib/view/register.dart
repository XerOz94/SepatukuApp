import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sepatuku_app/view/login.dart';
import 'package:sepatuku_app/services/firebase_auth_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void register() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    User? user =
        await _authService.signUpWithEmailandPassword(email, password, context);

    if (user != null) {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        // Menentukan path koleksi (misalnya, 'users') di Firestore
        String collectionPath = 'users';

        // Membuat dokumen dengan UID pengguna sebagai nama dokumen
        await firestore.collection(collectionPath).doc(user.uid).set({
          'username': username,
          'fb': "https://web.facebook.com/",
          'instagram': "https://web.instagram.com/",
          'github': "https://web.github.com/",
          'about': "No bio yet",
          'image':
              "https://firebasestorage.googleapis.com/v0/b/sepatukuapp.appspot.com/o/Default_pfp.png?alt=media&token=b7d6a442-174b-4cae-a2d9-fbccc636f155",
          'email': email,
          // Tambahkan data tambahan sesuai kebutuhan
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("User is successfully created"),
            backgroundColor: Colors.green));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Tidak dapat menyimpan data pengguna"),
          backgroundColor: Colors.red,
        ));
      }
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Cannot create User"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 30.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            const Text(
              "Register Account",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
            const Text(
              "Fill Your Details Account",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 50.0,
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Username",
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "Email Address",
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                prefixIcon:
                    Icon(Icons.lock), // Ganti Icons.key menjadi Icons.lock
                hintText: "Password",
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  register();
                },
                child: const Text(
                  "Sign up",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                const SizedBox(width: 4.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text(
                    "Login.",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
