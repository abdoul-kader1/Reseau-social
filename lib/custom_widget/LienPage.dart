import 'package:flutter/material.dart';

class LienPage extends MaterialPageRoute{
  LienPage({required Widget page}):super(
    builder: (contexte){
      return Scaffold(
        body: page,
      );
    }
  );

}