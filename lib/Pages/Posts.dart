import 'dart:io';
import 'package:flutter/material.dart';
import '../custom_widget/mytextfield.dart';
import 'package:image_picker/image_picker.dart';

import '../firebase/gestionnaireFirebase.dart';
class Posts extends StatefulWidget{

  String idMembre;

  Posts({super.key,required this.idMembre});

  @override
  PostsState createState() => PostsState();

}

class PostsState extends State<Posts>{

  late TextEditingController textEditingController;
  File?file;
  late ImagePicker picker;

  @override
  void initState() {
    textEditingController = TextEditingController();
    picker = ImagePicker();
    super.initState();
  }

  @override
  void dispose() {
   textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height*0.6,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))
      ),
      child: Container(
        child: Column(
          children: [
            Text("Ecris quelque chose"),
            SizedBox(height: 20),
            Mytextfield(controller: textEditingController,hint: "Ecrire un poste"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed:(){cameraOuGallery(ImageSource.camera);},
                    icon: Icon(Icons.camera_alt)
                ),
                IconButton(
                    onPressed:(){cameraOuGallery(ImageSource.gallery);},
                    icon: Icon(Icons.photo_library_outlined)
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width:MediaQuery.of(context).size.width*0.4,
              height: MediaQuery.of(context).size.width*0.4,
              child: (file==null)?Center(
                child: Text("Aucune photo choisir"),
              ):Image.file(file!),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: (){
                sendPost();
              },
              child: Container(
                width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.width*0.13,
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: Text('Valider le post',style: TextStyle(color: Colors.white))),
              ),
            )
          ],
        ),
      ),
    );
  }
  cameraOuGallery(ImageSource laSourceImage)async{
    final XFile? image = await  picker.pickImage(source:laSourceImage,maxWidth: 500,maxHeight: 500);
    if(image!=null){
      setState(() {
        file = File(image.path);
      });
    }
  }
  sendPost(){
    Navigator.pop(context);
    if(file!=null && textEditingController.text!=null && textEditingController.text!=null){
      GestionnaireFirbase().addToPost(widget.idMembre, textEditingController.text,file!);
    }
  }

}