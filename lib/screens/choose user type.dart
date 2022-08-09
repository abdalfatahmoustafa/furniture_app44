import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/screens/register%20driver.dart';
import 'package:furniture_app/screens/register%20screen.dart';
import 'package:provider/provider.dart';

import '../providers/auth provider.dart';

class ChooseTypeOfUser extends StatefulWidget {
  const ChooseTypeOfUser({Key? key}) :   super(key: key);

  @override
  _ChooseTypeOfUserState createState() => _ChooseTypeOfUserState();
}

class _ChooseTypeOfUserState extends State<ChooseTypeOfUser> {
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthProvider>().signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xffA64B2A),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Choose",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 100,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     SizedBox(
                       height: 150,
                       child: InkWell(child:Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           Icon(EvaIcons.hardDrive,size: 50,color: Colors.white,),
                           Text("Driver",style: TextStyle(color: Colors.white,fontSize: 20),)
                         ],
                       ),onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterDriver(),));
                       }, ),
                     ),
                     Container(margin:EdgeInsets.symmetric(horizontal: 50),child: Text("OR",style: TextStyle(color: Colors.white,fontSize: 30),)),
                     SizedBox(
                       height: 150,
                       child: InkWell(child:Column(
                         children: [
                           Icon(EvaIcons.person,size: 50,color: Colors.white,),
                           Text("User",style: TextStyle(color: Colors.white,fontSize: 20),)
                         ],
                       ),onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegister(),));

                       }, ),
                     )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
