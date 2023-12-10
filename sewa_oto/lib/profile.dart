import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/login.dart';
import 'package:mobile/widget/customNavBar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String username = '', uuid = '', email = '';

  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        uuid = user.uid;
        email = user.email ?? '';
        username = user.displayName ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
        backgroundColor: Color.fromARGB(255, 155, 151, 137),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _auth.signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 155, 151, 137),
              radius: 70,
              child: Icon(
                Icons.person,
                size: 80, // Ukuran ikon
                color: Colors.white, // Warna ikon
              ),
            ),
            SizedBox(height: 20),
            Text(
              username,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Email: $email',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
