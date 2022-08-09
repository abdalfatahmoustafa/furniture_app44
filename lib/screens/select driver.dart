import 'package:flutter/material.dart';
import 'package:furniture_app/providers/order%20provider.dart';
import 'package:furniture_app/screens/helper%20screen.dart';
import 'package:furniture_app/screens/select%20car%20type.dart';
import 'package:furniture_app/screens/select%20day%20and%20time%20screen.dart';
import 'package:provider/provider.dart';

class SelectDriver extends StatefulWidget {
  const SelectDriver({Key? key}) : super(key: key);

  @override
  _SelectDriverState createState() => _SelectDriverState();
}

class _SelectDriverState extends State<SelectDriver> {
  showDialog(BuildContext context) {
    return AlertDialog(
      content: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xff8E3200),
          height: MediaQuery.of(context).size.height ,
          child: SingleChildScrollView(
            child: Consumer<OrderProvider>(
              builder: (context, value, child) => Column(
                children: [
                  SizedBox(height: 30,),
                  Text(
                    "Choose Driver",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  for (int i = 0; i < value.allDrivers.length; i++)
                    InkWell(
                      onTap: () {
                        value.chooseDriver(i);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseHelpers(),
                            ));
                      },
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                        elevation: 0,
                        shadowColor: Colors.white,
                        color: Color(0x99D7A86E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Container(
                          //height: MediaQuery.of(context).size.width *.7,
                          width: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: CircleAvatar(
                                  radius: 40,
                                  child: ClipRRect(
                                    child: Image.network(
                                      value.allDrivers[i].photoUrl!,
                                      //List<dynamic> [{},{}]
                                      height: 100,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "  " + value.allDrivers[i].name!,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  Text(
                                    "  " + value.allDrivers[i].phone!,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  Text(
                                    "   " +
                                        value.allDrivers[i].pricePerKilo
                                            .toString() +
                                        "\$ per Km",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
