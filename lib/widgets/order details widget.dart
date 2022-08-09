import 'package:flutter/material.dart';

class OrderDetailsWidget extends StatelessWidget {
  final String orderDetailName;
  final dynamic value;
  const OrderDetailsWidget({Key? key,required this.value,required this.orderDetailName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color(0xffFFEBC1),
        elevation: 5,
        shadowColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(

            children: [
              Text("$orderDetailName : ",style: TextStyle(fontSize: 18,color: Color(0xffAE0000)),),
              Text("$value",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
            ],
          ),
        ),
      ),
    );
  }
}
