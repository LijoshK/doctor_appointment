import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/screens/doctor/doc_updateprofile.dart';
import 'package:doctor_appointment/screens/loginpg.dart';
import 'package:doctor_appointment/screens/doctor/doc_bookingpg.dart';
import 'package:doctor_appointment/screens/doctor/doc_historypg.dart';
import 'package:doctor_appointment/utilities/resources.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dochomepg extends StatefulWidget {
  const Dochomepg({Key? key}) : super(key: key);

  @override
  State<Dochomepg> createState() => _DochomepgState();
}

class _DochomepgState extends State<Dochomepg> {
  int selectedIndex = 0;
  List screens = [];

  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = await preferences.getString("id");
    var data = await FirebaseFirestore.instance.collection("doctor").doc(id).get();
    var details= await data.data();
    setState(() {
      usrname=details!["docname"];
      uname=details["docemail"];
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          drawer: Drawer(
            backgroundColor: Appresrc().colors1,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 280),
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close)),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                              height: 100,
                              width: 80,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  shape: BoxShape.circle)),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  usrname.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  uname.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    // Positioned(
                    //   top: 65,
                    //   left: 55,
                    //   child: Container(
                    //       decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blue),
                    //       child: Icon(Icons.add,color: Colors.white,)),
                    // ),
                    Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Docupdtprfle(),
                          ));
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Update Profile",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Icon(Icons.person)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black,
                    ),
                    // SizedBox(height: 360,),
                    Divider(
                      height: 1,
                      color: Colors.black,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Loginpg()),
                            (Route<dynamic> route) => false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Appresrc().colors1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Center(
                            child: Text("LogOut",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // appBar: AppBar(
          //   toolbarHeight: 0,
          //   bottom: TabBar(tabs: [
          //
          //     Tab(
          //       icon: Icon(Icons.notification_add_outlined),
          //       text: "Bookings",
          //     ),
          //     Tab(
          //       icon: Icon(Icons.history_rounded),
          //       text: "History",
          //     ),
          //   ]),
          // ),
          appBar: AppBar(
            backgroundColor: Appresrc().colors1,
            toolbarHeight: 0,
            bottom: TabBar(
                onTap: (index) {
                  selectedIndex = index;
                },
                tabs: [
                  Tab(
                    icon: Icon(Icons.notification_add_outlined),
                    text: "Bookings",
                  ),
                  Tab(
                    icon: Icon(Icons.history_rounded),
                    text: "History",
                  ),
                ]),
          ),
          body: TabBarView(
            children: [Docbookingpg(), Docapproving()],
          )
          // screens[],
          ),
    );
  }
}
