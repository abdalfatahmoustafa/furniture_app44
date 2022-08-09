import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furniture_app/models/driver%20model.dart';
import 'package:furniture_app/providers/driver%20provider.dart';
import 'package:furniture_app/widgets/textFieldWidget.dart';
import 'package:furniture_app/widgets/validators.dart';
import 'package:provider/provider.dart';

import '../providers/auth provider.dart';
import 'LoginScreenD.dart';

class RegisterDriver extends StatefulWidget {
  const RegisterDriver({Key? key}) : super(key: key);

  @override
  _RegisterDriverState createState() => _RegisterDriverState();
}

class _RegisterDriverState extends State<RegisterDriver> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController carNumber = TextEditingController();
  List<String> xs = ["abdelfatah ", "moustafa"];

  String x = "abdelfatah";
  int? _radioSelected;
  String _radioVal = "";
  final _formKey = GlobalKey<FormState>();
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthProvider>().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0x888E3200)
                // image: DecorationImage(
                //     image: AssetImage("images/login.jpg"),
                //     fit: BoxFit.fitHeight,
                //     opacity: .3)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Driver Registeration",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                ),
                SizedBox(
                  height: 25,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                          obsecure: true,
                          hint: "Enter Pasword",
                          controller: password,
                        ),
                        TextFieldWidget(
                          validator: phoneValidator,
                          obsecure: false,
                          hint: "Enter phone",
                          controller: phone,
                        ),
                        TextFieldWidget(
                          validator: pricePerKiloValidator,
                          obsecure: false,
                          hint: "Enter Your Price per Killo",
                          controller: price,
                        ),
                        TextFieldWidget(
                          validator: carNumberValidator,
                          obsecure: false,
                          hint: "Enter Your Car Number",
                          controller: carNumber,
                        ),
                      ],
                    )),
                ListTile(
                  leading: Text(
                    "Choose Your Car Type",
                    style: TextStyle(fontSize: 20,color: Color(0xffFFEBC1),fontWeight: FontWeight.bold),
                  ),
                ),
                RadioListTile(
                  value: 1,
                  groupValue: _radioSelected,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _radioSelected = value as int;
                      _radioVal = 'Pickup Truck';
                      print(_radioVal);
                    });
                  },
                  title: Text("Pickup Truck",style: TextStyle(color: Colors.white),),
                ),
                RadioListTile(
                  value: 2,
                  groupValue: _radioSelected,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _radioSelected = value as int;
                      _radioVal = 'Cargo Van';
                      print(_radioVal);
                    });
                  },
                  title: Text("Cargo Van",style: TextStyle(color: Colors.white)),
                ),
                RadioListTile(
                  value: 3,
                  groupValue: _radioSelected,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _radioSelected = value as int;
                      _radioVal = 'Box Truck';
                      print(_radioVal);
                    });
                  },
                  title: Text("Box Truck",style: TextStyle(color: Colors.white)),
                ),
                RadioListTile(
                  value: 4,
                  groupValue: _radioSelected,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _radioSelected = value as int;
                      _radioVal = 'Winch';
                      print(_radioVal);
                    });
                  },
                  title: Text("Winch",style: TextStyle(color: Colors.white)),
                ),
                SizedBox(
                  height: 25,
                ),
                Text("Choose Image",style: TextStyle(color: Colors.white,fontSize: 20)),
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
                              primary: Colors.white
                          ),
                          onPressed: () {
                            context.read<DriverProvider>().pickImage("cam");
                          },
                          child: Text("Camera",style: TextStyle(color: Color(0xff8E3200)))),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white
                        ),
                          onPressed: () {
                            context.read<DriverProvider>().pickImage("gallery");
                          },
                          child: Text("Gallery",style: TextStyle(color: Color(0xff8E3200)),)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<DriverProvider>(
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
                        if (_formKey.currentState!.validate() &&
                            _radioVal != "" &&
                            context.read<DriverProvider>().image != null) {
                          DriverModel d = DriverModel(
                              name: name.text,
                              available: true,
                              carNumber: int.parse(carNumber.text),
                              carType: _radioVal,
                              email: email.text,
                              phone: phone.text,
                              pricePerKilo: num.parse(price.text));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Wait..."),
                          ));
                          await context
                              .read<DriverProvider>()
                              .registerDriverWithEmailAndPassword(
                                  d, password.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff8E3200),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      child: Text("Register")),
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
                                builder: (context) => LoginScreenD(),
                              ));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        )),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
