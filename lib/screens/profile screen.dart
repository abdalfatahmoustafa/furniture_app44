import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/providers/auth%20provider.dart';
import 'package:furniture_app/providers/user%20provider.dart';
import 'package:furniture_app/screens/location%20screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Color(0xffFFEBC1),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width * .90,
                  child: Card(
                    elevation: 25,
                    color: Color(0xff8E3200),
                    shadowColor: Colors.black54,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            context.watch<AuthProvider>().user.photoUrl!,
                          ),
                          radius: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            context.watch<AuthProvider>().user.name!,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            context.watch<AuthProvider>().user.email!,
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .6,
                  width: MediaQuery.of(context).size.width * .90,
                  child: Card(
                    elevation: 25,
                    color: Color(0xffD7A86E),
                    shadowColor: Colors.black54,
                    child: Consumer<UserProvider>(
                      builder: (context, value, child) => ListView(
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * .1,
                                  vertical: 10),
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width * .7,
                              child: Text(
                                "My Orders",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xff8E3200)),
                              )),
                          (value.orders.isNotEmpty)
                              ? Column(
                                  children: [
                                    for (int i = 0;
                                        i < value.orders.length;
                                        i++)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .7,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 20,
                                                                  horizontal:
                                                                      10),
                                                          primary:
                                                              Colors.white),
                                                  onPressed: () {},
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "order : ${i + 1}\n",
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff8E3200),
                                                                fontSize: 15),
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              value.deleteOrder(
                                                                  i);
                                                            },
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            icon: Icon(
                                                              Icons.close,
                                                              color: Colors.red,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Text(
                                                          "Number Of Items : ${value.orders[i].numberOfItems}\n",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff8E3200),
                                                              fontSize: 15)),
                                                      Text(
                                                          "Price :  ${value.orders[i].price}\$\n",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff8E3200),
                                                              fontSize: 15)),
                                                      Text(
                                                          "Date :  ${value.orders[i].dateTime!.day}/${value.orders[i].dateTime!.month}/ ${value.orders[i].dateTime!.year}  ${value.orders[i].dateTime!.hour}:${value.orders[i].dateTime!.minute}\n",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff8E3200),
                                                              fontSize: 15)),
                                                    ],
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                  ],
                                )
                              : (value.orders.isEmpty && value.getOrders)
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(top: 100),
                                            alignment: Alignment.center,
                                            child: Text("No Items Yet")),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 100),
                                          child: CircularProgressIndicator(),
                                          width: 50,
                                          height: 50,
                                          alignment: Alignment.center,
                                        ),
                                      ],
                                    )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationScreen(),
              ));
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.purple,
        ),
      ),
    );
  }
}
