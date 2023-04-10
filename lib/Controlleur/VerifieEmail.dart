import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'acceuil.dart';

class VerifiEmail extends StatefulWidget{

  VerifiEmail({super.key});

  @override
  StateVerifiEmail  createState() =>StateVerifiEmail();
}

class StateVerifiEmail extends State<VerifiEmail>{

  bool isVerify = false;
   Timer?timer;

  @override
  void initState() {
    sendEmail();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  sendEmail()async{
    isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isVerify){
      try{
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        timer = Timer.periodic(Duration(seconds: 3), (_)=>CheckEmailVerifie());
      }catch(e){
        print(e);
      }
    }
  }
  CheckEmailVerifie()async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isVerify){
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isVerify)
        ?Acceuil()
        :Scaffold(
      appBar: AppBar(
        title: Text("Vérification de l'email"),
      ),
      body: Center(
        child: Text("un email de confirmation a été envoyé a votre mail"),
      ),
    );
  }
}