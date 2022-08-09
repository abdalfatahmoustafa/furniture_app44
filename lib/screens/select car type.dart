import 'package:flutter/material.dart';
import 'package:furniture_app/providers/order%20provider.dart';
import 'package:furniture_app/screens/select%20driver.dart';
import 'package:provider/provider.dart';

import '../widgets/alert dialog.dart';

class SelectCar extends StatefulWidget {
  const SelectCar({Key? key}) : super(key: key);

  @override
  _SelectCarState createState() => _SelectCarState();
}

List<String> carTypes = ["Pickup Truck", "Cargo Van", "Box Truck", "Winch"];
List<String> carImages = [
  'box truck.jpg',
  'cargo van.jpg',
  'pickup.jpg',
  'winch.jpg'
];

class _SelectCarState extends State<SelectCar> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height * .6,
            color: Color(0xff8E3200),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                 SizedBox(
                   height: 20,
                 ),
                  Text(
                    "Choose Car Type",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  for (int i = 0; i < 4; i++)
                    InkWell(
                      onTap: () async {
                        showDialoge(context);
                        await context
                            .read<OrderProvider>()
                            .getDrivers(carTypes[i]);
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectDriver(),
                            ));
                        Navigator.pop(context);
                      },
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        elevation: 20,
                        color: Color(0xffFFEBC1),
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
                                    vertical: 15, horizontal: 15),
                                child: ClipRRect(
                                  child: Image.asset(
                                    "images/" + carImages[i],
                                    height: 100,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "   " + carImages[i].split(".")[0],
                                style: TextStyle(
                                    color: Color(0xff8E3200), fontSize: 25,fontWeight: FontWeight.w500),
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
