import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Acceuil extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_Acceuil();
}

class _Acceuil extends State<Acceuil>{
  @override
  Widget build(BuildContext context) {
    final users = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Acceuil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("votre identifiant est : ${users?.uid}"),
            Text("votre e-mail est : ${users?.email}"),
            ElevatedButton(
                onPressed: ()async{
                  await FirebaseAuth.instance.signOut();
                  },
                child: Text("Se deconnecter")
            )
          ],
        ),
      ),
 );
}
}
