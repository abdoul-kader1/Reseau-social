import 'package:flutter/material.dart';

class BarDeNavigation extends ChangeNotifier{

  int index = 0;

  changeEtat(int valeur){
    index = valeur;
    notifyListeners();
  }
}