import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/providers/auth%20provider.dart';
import 'package:furniture_app/screens/profile%20screen.dart';
import 'package:furniture_app/screens/register%20screen.dart';
import 'package:furniture_app/widgets/alert%20dialog.dart';
import 'package:provider/provider.dart';

import '../widgets/loginTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthProvider>().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: Color(0xff8E3200)
                //image: DecorationImage(
                //  image: AssetImage(
                //  "images/login.jpg",
                // ),
                //opacity: 1,
                //fit: BoxFit.fitHeight)
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
                  child: Text("Furniture App",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFFEBC1))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                ),
                LoginTextFieldWidget(
                  hint: "Email",
                  obsecure: false,
                  suffixIcon: Icons.email_outlined,
                  controller: emailController,
                ),
                LoginTextFieldWidget(
                  hint: "Password",
                  obsecure: true,
                  suffixIcon: EvaIcons.lock,
                  controller: passwordController,
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .6,
                  child: ElevatedButton(
                      onPressed: () async {
                        showDialoge(context);
                        var res = await context.read<AuthProvider>().userSignIn(
                            emailController.text.trim(),
                            passwordController.text.trim());
                        if (res != null) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(res),
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(),
                              ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 15,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: const Text(
                        "Login",
                        style:
                            TextStyle(color: Color(0xff8E3200), fontSize: 18),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserRegister(),
                          ));
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
