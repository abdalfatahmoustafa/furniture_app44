import 'package:flutter/material.dart';
import 'package:furniture_app/providers/order%20provider.dart';
import 'package:furniture_app/screens/items%20screen.dart';
import 'package:provider/provider.dart';

class ChooseHelpers extends StatefulWidget {
  const ChooseHelpers({Key? key}) : super(key: key);

  @override
  _ChooseHelpersState createState() => _ChooseHelpersState();
}

class _ChooseHelpersState extends State<ChooseHelpers> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  // }
  @override
  Widget build(BuildContext context) {
    Map<int, int> numberOfHelpers = {1: 10, 2: 15, 3: 25, 4: 35, 5: 45, 6: 55};
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0xff8E3200)
              // image: DecorationImage(
              //     image: AssetImage("images/login.jpg"),
              //     fit: BoxFit.cover,
              //     opacity: .40)
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*.7,
                child: Text(
                  "Choose Number Of Helpers",
                  textAlign: TextAlign.center,
                  style: TextStyle(color:Colors.white,fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin:EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .8,
                child: GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: [
                    for (int i = 0; i < numberOfHelpers.keys.length; i++)
                      InkWell(
                        onTap: () {
                          context.read<OrderProvider>().chooseNumberOfHelpers(
                              numberOfHelpers.keys.toList()[i],
                              numberOfHelpers[i + 1]!);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseItems(),));
                        },
                        child: Card(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${numberOfHelpers.keys.toList()[i]}",
                              style: TextStyle(fontSize: 28,color: Color(0xff8E3200),fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Helpers",
                              style:
                                  TextStyle(color: Color(0xffA64B2A), fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${numberOfHelpers[i + 1]} ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    "\$",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
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
