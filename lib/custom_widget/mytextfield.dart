import 'package:flutter/material.dart';

class Mytextfield extends TextField{

  Mytextfield({
    required TextEditingController controller,
    TextInputType text:TextInputType.text,
    Icon?icon,
    bool obscure:false,
    String hint:""
}):super(
    controller: controller,
    keyboardType: text,
    obscureText: obscure,
    decoration:InputDecoration(
      icon: icon,
      hintText: hint
    )
  );
}