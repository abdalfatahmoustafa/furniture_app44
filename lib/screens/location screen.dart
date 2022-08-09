import 'package:flutter/material.dart';
import 'package:furniture_app/providers/order%20provider.dart';
import 'package:furniture_app/screens/items%20screen.dart';
import 'package:furniture_app/screens/select%20car%20type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OrderProvider>().getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
        //   image: DecorationImage(
        //   image: AssetImage("images/login.jpg"),
        //     fit: BoxFit.cover,
        //     opacity: .4
        // )
              color: Color(0xff8E3200)
      ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text("Identify Location",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                ),
                Container(
                  height: 500,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Consumer<OrderProvider>(
                    builder :(context, value, child) =>  GoogleMap(
                      onMapCreated: (controller) {
                        value.googleMapController=controller;
                      },
                      markers: value.myMarkers,
                      zoomControlsEnabled: true,
                      initialCameraPosition: CameraPosition(target: LatLng(value.lat,value.long),zoom: 15),
                      onTap: (LatLng latLng){
                        // print(currentLocation.longitude);
                        // print(currentLocation.latitude);
                        value.getDestination(latLng);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                // ElevatedButton(onPressed: (){
                //   context.read<OrderProvider>().getCurrentLocation();
                // }, child: Text("child")),
                Text("Click on location you want to reach",style: TextStyle(color: Colors.white,fontSize: 18),),
                SizedBox(height: 50,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffFFEBC1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                  ),
                    onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectCar(),));
                }, child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 10),
                  child: Text("Submit",style: TextStyle(color: Color(0xff8E3200)),),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
