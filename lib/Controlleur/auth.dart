import 'package:flutter/material.dart';
import 'package:reseausocial/firebase/gestionnaireFirebase.dart';
import '../Modele/alerteHelper.dart';
import '../Modele/couleur_theme.dart';
import '../Modele/mypainter.dart';
import '../custom_widget/mygradient.dart';
import '../custom_widget/mytextfield.dart';
import '../custom_widget/paddingwidth.dart';

class Auth extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_Auth();

}

class _Auth extends State<Auth>{
  late PageController _pageController;
  late TextEditingController _nom;
  late TextEditingController _prenom;
  late TextEditingController _email;
  late TextEditingController _mdp;

  @override
  void initState() {
    _pageController =PageController();
    _nom=TextEditingController();
    _prenom=TextEditingController();
    _email=TextEditingController();
    _mdp=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _pageController.dispose();
    _nom.dispose();
    _prenom.dispose();
    _email.dispose();
    _mdp.dispose();
    super.dispose();
  }
  hideKeborad(){
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWell(
          onTap:(){
            hideKeborad();
          },
          child: Container(
            decoration: Mygradient(startcolors:Colorstheme().Primary(),endcolors: Colorstheme().Base()),
            width: MediaQuery.of(context).size.width,
            height:(MediaQuery.of(context).size.height>700)?MediaQuery.of(context).size.height:700,
            child: SafeArea(
              child: Column(
                children: [
                  PaddingWidth(
                      child: Image.asset("assets/darkBee.png",height: MediaQuery.of(context).size.height/5)
                  ),
                  logOrCreatButtom(),
                  Expanded(
                      child: PageView(
                        controller: _pageController,
                        children: [
                          logCards(UserExiste:true),
                          logCards(UserExiste: false)
                        ],
                      ),
                    flex: 2,
                  ),
                  PaddingWidth(
                      child: TextButton(
                        onPressed: (){
                          VerifeiChampDeSaisie();
                        },
                        child:Container(
                          decoration: Mygradient(
                            radius: 25,
                            horizontal: true,
                            startcolors: Colorstheme().Accent(),
                            endcolors: Colorstheme().Primary()
                          ),
                          height: 50,
                          width: MediaQuery.of(context).size.width*0.7,
                          child:Center(child: Text("C'est partir !",style: TextStyle(color: Colors.white),)),
                        ),
                      )
                  )
                ],
              ),
            ),
          )
        )
      ),
    );
  }

  Widget logOrCreatButtom(){
    return Container(
      decoration: Mygradient(startcolors: Colorstheme().Accent(),endcolors:Colorstheme().Primary(),radius: 25),
      width: 300,
      height: 50,
      child: CustomPaint(
        painter:Mypainter(pageController: _pageController),
        child: Row(
          children: [
            btn(name:"Se connecter"),
            btn(name:"Créé un compte")
          ],
        ),
      ),
    );
  }

  Expanded btn({required String name}){
    return Expanded(
        child: TextButton(
          child: Text(name,style: TextStyle(color: Colors.blue),),
          onPressed: (){
            int page =(_pageController.page==0.0)?1:0;
            _pageController.animateToPage(
                page,
                duration:Duration(microseconds: 500),
                curve:Curves.bounceOut
            );
          },
        )
    );
  }

  Widget logCards({required bool UserExiste}){
    List<Widget>list=[];
    if(!UserExiste){
      list.add(Mytextfield(controller:_nom,hint: "Entrer votre nom"));
      list.add(Mytextfield(controller:_prenom,hint: "Entrer votre prenom"));
    }
    list.add(Mytextfield(controller:_email,hint: "Entrer votre email"));
    list.add(Mytextfield(controller:_mdp,obscure: true,hint: "Entrer votre mot de passe"));
    return PaddingWidth(
        child:Center(
          child: Card(
            elevation: 7.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:list,
              mainAxisSize: MainAxisSize.min,
            ),
          ),
        ),
      bottom: 100,
    );
  }

  VerifeiChampDeSaisie(){
    bool singIn = _pageController.page==0;
    hideKeborad();
    String nom =_nom.text;
    String prenom = _prenom.text;
    String email = _email.text;
    String mdp = _mdp.text;
    if( (ConditionChampSaisie(email)) && (ConditionChampSaisie(mdp)) ){
      if(singIn){
        GestionnaireFirbase().Connextion(email: email, mdp: mdp).then((value) => (e){
          AlerteHelper().Erreur(contexte: context,erreur: e);
        });
      }else{
        if((ConditionChampSaisie(nom)) && (ConditionChampSaisie(prenom))){
          GestionnaireFirbase().Enregistrer(email: email, mdp: mdp, nom: nom, prenom: prenom).then((value) => (e){
            AlerteHelper().Erreur(contexte: context,erreur: e);
          });
        }else{
          AlerteHelper().Erreur(contexte: context,erreur: "Nom ou Prenom vide");
        }
      }
    }else{
      AlerteHelper().Erreur(contexte: context,erreur: "Mail ou mot de passe vide");
    }
  }

  bool ConditionChampSaisie(String string){
    return (string!=null && string!="");
  }

}
