import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/providers/order%20provider.dart';
import 'package:furniture_app/providers/user%20provider.dart';
import 'package:furniture_app/screens/profile%20screen.dart';
import 'package:furniture_app/widgets/alert%20dialog.dart';
import 'package:furniture_app/widgets/order%20details%20widget.dart';
import 'package:provider/provider.dart';

class ReviewOrder extends StatefulWidget {
  const ReviewOrder({Key? key}) : super(key: key);

  @override
  _ReviewOrderState createState() => _ReviewOrderState();
}

class _ReviewOrderState extends State<ReviewOrder> {
  static Route<void> _myRouteBuilder(BuildContext context, Object? arguments) {
    return MaterialPageRoute<void>(
      builder: (BuildContext context) => const ProfileScreen(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff8E3200)
              //image: DecorationImage(image: AssetImage("images/login.jpg"),fit: BoxFit.cover,opacity: .4)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Consumer<OrderProvider>(
                builder: (context, value, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Order Review",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Color(0xffFFEBC1),
                        elevation: 5,
                        shadowColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Text("price : ",style: TextStyle(fontSize: 18,color: Color(0xffAE0000)),),
                              Text("${value.order.price}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              Text("\$",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    OrderDetailsWidget(value: value.order.numberOfItems, orderDetailName: "Number Of Items"),
                    OrderDetailsWidget(value: value.order.numberOfHelpers, orderDetailName: "Number Of Helpers"),
                    OrderDetailsWidget(value: value.order.carType, orderDetailName: "Car Type"),
                    OrderDetailsWidget(value: value.driver!.name, orderDetailName: "Driver Name"),
                    OrderDetailsWidget(value: value.driver!.phone, orderDetailName: "Driver Number"),
                    OrderDetailsWidget(value: value.driver!.carNumber, orderDetailName: "Car Number"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Color(0xffFFEBC1),
                        elevation: 5,
                        shadowColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Text("Price Per Kilo : ",style: TextStyle(fontSize: 18,color: Color(0xffAE0000)),),
                              Text("${value.driver!.pricePerKilo}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              Text("\$",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    OrderDetailsWidget(value: value.order.dateTime.toString().split(" ")[0], orderDetailName: "Date"),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0,bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: ()async{
                            showDialoge(context);
                            await value.addOrderToFirebase();
                            await context.read<UserProvider>().getAllOrders();
                            Navigator.pop(context);
                            context.read<OrderProvider>().clearOrder();
                            //  await Navigator.of(context).restorablePushReplacement(
                            //   _myRouteBuilder,
                            // );
                            Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => ProfileScreen(),
                              ),
                                  (route) => false,//if you want to disable back feature set to false
                            );

                          },
                              child: Text("Submit Order",style: TextStyle(fontSize: 20),),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffD7A86E),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              padding: EdgeInsets.symmetric(horizontal: 70,vertical: 10)
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
