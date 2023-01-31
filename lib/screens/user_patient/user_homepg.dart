import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/screens/loginpg.dart';
import 'package:doctor_appointment/screens/user_patient/user_bookingpg.dart';
import 'package:doctor_appointment/screens/user_patient/user_historypg.dart';
import 'package:doctor_appointment/screens/user_patient/user_updateprofile.dart';
import 'package:doctor_appointment/utilities/resources.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userhomepg extends StatefulWidget {
  const Userhomepg( {Key? key}) : super(key: key);

  @override
  State<Userhomepg> createState() => _UserhomepgState();
}

class _UserhomepgState extends State<Userhomepg> {
  int selectedIndex = 0;
  List screens = [];

  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id= await preferences.getString("id");
    var data= await FirebaseFirestore.instance.collection("patient").doc(id).get();
    var details= await data.data();
    setState(() {
      usrname=details!["username"];
      uname=details["useremail"];
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
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  usrname.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  uname.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black,
                    ),
                    // Icon(Icons.add,color: Colors.blue,),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Userupdtprfle(),
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
                      height: 2,
                      color: Colors.black,
                    ),
                    InkWell(
                      onTap: () {
                        // FirebaseAuth.instance.signOut();
                        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        //   builder: (context) => Loginpg(),
                        // ));
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => Loginpg(),
                            ),
                            (Route<dynamic> route) => false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 80,
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
            children: [Userbookingpg(), Userhistorypg()],
          )),
    );
  }
}