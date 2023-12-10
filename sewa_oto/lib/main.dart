import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // app = await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:1088778539594:android:46b550e0c377bf13218cb3',
      apiKey: 'AIzaSyDnscsdEoCojv5bMPW5CSQSj8eQXpDBbBw',
      messagingSenderId: '1088778539594',
      projectId: 'my-community-d8ab0',
    ),
  );
  runApp(Home());
}

class Home extends StatelessWidget {
  Home({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTS',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Login(),
    );
  }
}
