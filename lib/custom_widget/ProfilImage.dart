import 'package:flutter/material.dart';

class ProfileImage extends InkWell{
  ProfileImage({super.key, required String url, required VoidCallback onPressed , double imageSize = 20}):super(
    onTap: onPressed,
    child: CircleAvatar(
      backgroundColor: Colors.orange,
      radius: imageSize,
      backgroundImage: (url!=null && url!="")?NetworkImage(url):NetworkImage("https://images.pexels.com/photos/1499327/pexels-photo-1499327.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
    )
  );
}