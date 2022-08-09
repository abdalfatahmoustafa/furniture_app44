import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/data/data.dart';
import 'package:furniture_app/providers/auth%20provider.dart';
import 'package:furniture_app/providers/order%20provider.dart';
import 'package:furniture_app/providers/user%20provider.dart';
import 'package:furniture_app/screens/final%20order%20screen.dart';
import 'package:furniture_app/screens/profile%20screen.dart';
import 'package:furniture_app/screens/select%20day%20and%20time%20screen.dart';
import 'package:furniture_app/widgets/alert%20dialog.dart';
import 'package:provider/provider.dart';

class ChooseItems extends StatefulWidget {
  const ChooseItems({Key? key}) : super(key: key);

  @override
  _ChooseItemsState createState() => _ChooseItemsState();
}

class _ChooseItemsState extends State<ChooseItems> {
  static Route<void> _myRouteBuilder(BuildContext context, Object? arguments) {
    return MaterialPageRoute<void>(
      builder: (BuildContext context) => const ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Color(0xff8E3200)
              //image: DecorationImage(image: AssetImage("images/login.jpg"),fit: BoxFit.cover,opacity: .5)
              ),
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "Choose Items",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 30),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .45,
                margin: EdgeInsets.only(top: 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(0)),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      print(items.keys.toList()[index]);
                      String key = items.keys.toList()[index];
                      showItemOptionsDialog(context, key);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 15,
                        color: Color(0xffFFEBCf),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "${items.keys.toList()[index]}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff8E3200),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemCount: items.keys.length,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Order Items",
                      style: TextStyle(
                          color: Color(0xffFFEBCf),
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .24,
                width: double.infinity,
                child: Consumer<OrderProvider>(
                  builder: (context, value, child) => (value
                          .order.items.isNotEmpty)
                      ? ListView.builder(
                          itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.only(bottom: 50, top: 25),
                            child: Card(
                              color: Color(0xffFFEBC1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text("Name : " +
                                            value.order.items[index].item!),
                                        Row(
                                          children: [
                                            Text("Total price :" +
                                                value.order.items[index].price
                                                    .toString()),
                                            Text(
                                              "\$",
                                              style: TextStyle(
                                                  color: Colors.green),
                                            )
                                          ],
                                        ),
                                        Text(
                                            "Number Of ${value.order.items[index].item!} : " +
                                                value.order.items[index].number
                                                    .toString()),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        value.deleteItem(index);
                                      },
                                      icon: Icon(Icons.close,color: Colors.red,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          itemCount: value.order.items.length,
                          scrollDirection: Axis.horizontal,
                        )
                      : Container(
                          child: Text(
                            "No Items Added Yet!",
                            style: TextStyle(color: Color(0xffFFEBCf)),
                          ),
                          alignment: Alignment.center,
                        ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xffFFEBC1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(horizontal: 100)),
                  onPressed: () async {
                    context.read<OrderProvider>().calcNumberOfItemsAndPrice();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectDay(),
                        ));
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Color(0xff8E3200),
                        fontWeight: FontWeight.w300,
                        fontSize: 28),
                  ))
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     context.read<AuthProvider>().getCurrentUser();
      //   },
      //   backgroundColor: Colors.white,
      //   child: Icon(Icons.add,color: Colors.pink,size: 30,),
      // ),
    );
  }
}
