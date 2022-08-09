import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:furniture_app/providers/order%20provider.dart';
import 'package:furniture_app/screens/final%20order%20screen.dart';
import 'package:furniture_app/screens/items%20screen.dart';
import 'package:provider/provider.dart';

class SelectDay extends StatefulWidget {
  const SelectDay({Key? key}) : super(key: key);

  @override
  _SelectDayState createState() => _SelectDayState();
}

class _SelectDayState extends State<SelectDay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xff8E3200),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Text("Choose Time And Date",textAlign: TextAlign.center,style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  
                  height: MediaQuery.of(context).size.height * .5,
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                  child: CalendarCarousel(
                    onDayPressed: (day, list) {
                      displayTimePicker(context, day);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  displayTimePicker(BuildContext context, DateTime dateTime) async {
    final timeOfDate = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        confirmText: "confirm",

        initialEntryMode: TimePickerEntryMode.dial);
    if (timeOfDate != null) {
      context.read<OrderProvider>().selectDateAndTime(dateTime, timeOfDate);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewOrder(),));
    }
    //print(timeOfDate);
  }
}
