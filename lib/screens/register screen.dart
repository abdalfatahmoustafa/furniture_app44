import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furniture_app/models/user%20model.dart';
import 'package:furniture_app/providers/auth%20provider.dart';
import 'package:furniture_app/providers/user%20provider.dart';
import 'package:furniture_app/screens/login%20screen.dart';
import 'package:furniture_app/screens/profile%20screen.dart';
import 'package:furniture_app/widgets/alert%20dialog.dart';
import 'package:furniture_app/widgets/validators.dart';
import 'package:provider/provider.dart';

import '../providers/driver provider.dart';
import '../widgets/textFieldWidget.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);

  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthProvider>().signOut();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*1.1,
            decoration: BoxDecoration(color: Color(0xff8E3200)
                //image: DecorationImage(image: AssetImage("images/login.jpg"),fit: BoxFit.cover,opacity: .3)
                ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "User Registeration",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFieldWidget(
                    validator: nameValidator,
                    obsecure: false,
                    hint: "Enter Full Name",
                    controller: name,
                  ),
                  TextFieldWidget(
                    validator: emailValidator,
                    obsecure: false,
                    hint: "Enter Email",
                    controller: email,
                  ),
                  TextFieldWidget(
                    validator: passwordValidator,
                    obsecure: false,
                    hint: "Enter Pasword",
                    controller: password,
                  ),
                  TextFieldWidget(
                    validator: phoneValidator,
                    obsecure: false,
                    hint: "Enter phone",
                    controller: phone,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Choose Image",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffFFEBC1)),
                            onPressed: () {
                              context.read<AuthProvider>().pickImage("cam");
                            },
                            child: Text(
                              "Camera",
                              style: TextStyle(color: Color(0xff8E3200)),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffFFEBC1)),
                            onPressed: () {
                              context.read<AuthProvider>().pickImage("cdam");
                            },
                            child: Text(
                              "Gallery",
                              style: TextStyle(color: Color(0xff8E3200)),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<AuthProvider>(
                    builder: (context, value, child) {
                      if (value.image != null) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(65),
                          clipBehavior: Clip.hardEdge,
                          child: Image.file(
                            File(value.image!.path),
                            fit: BoxFit.cover,
                            width: 80 * 2,
                            height: 80 * 2,
                          ),
                        );
                      } else {
                        return CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          child: Text("No Image Yet!"),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .8,
                    child: ElevatedButton(
                        onPressed: () async {
                          if(formKey.currentState!.validate()&&
                              context.read<AuthProvider>().image != null){
                            UserModel u = UserModel(
                              name: name.text,
                              email: email.text,
                              phone: phone.text,
                            );
                            showDialoge(context);
                            var res = await context
                                .read<AuthProvider>()
                                .registerUserWithEmailAndPassword(
                                u, password.text);
                            if (res == null) {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ));
                            } else {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(res),
                                duration: Duration(seconds: 2),
                              ));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xffFFEBC1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.symmetric(vertical: 10)),
                        child: Text(
                          "Register",
                          style: TextStyle(color: Color(0xff8E3200)),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("already has account",
                          style: TextStyle(color: Colors.white, fontSize: 13)),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
