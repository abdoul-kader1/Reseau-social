import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Controlleur/VerifieEmail.dart';
import 'Controlleur/auth.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (BuildContext context,snapshot){
          return (snapshot.hasData)?VerifiEmail():Auth();
        },
      ),
    );
  }
}
