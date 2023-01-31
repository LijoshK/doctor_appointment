import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/utilities/resources.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Userbookingpg extends StatefulWidget {
  const Userbookingpg({Key? key}) : super(key: key);

  @override
  State<Userbookingpg> createState() => _UserbookingpgState();
}

class _UserbookingpgState extends State<Userbookingpg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          width: 350,
          decoration: BoxDecoration(
              color: Appresrc().colors1,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: TextField(
            controller: searchtxt,
            // onChanged: (value){
            //   showdata(value);
            //   search=true;
            // },
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.search),
              ),
              hintText: "Search doctor",
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Title(
            color: Colors.black,
            child: Center(
              child: Text("Doctors_Available",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            )),
      ),
      Expanded(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection("doctor").snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                              color: Appresrc().colors1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://www.shutterstock.com/image-vector/man-icon-vector-260nw-1040084344.jpg",
                              ),
                            ),
                            title: Text(
                                snapshot.data!.docs[index].data()["docname"]),
                            subtitle: Text(snapshot.data!.docs[index]
                                .data()["docspecialized"]),
                            trailing: InkWell(
                              onTap: () async {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          backgroundColor: Appresrc().colors1,
                                          title: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(28))),
                                            child: Column(
                                              children: [
                                                // Text("data"),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Title(
                                                      color: Colors.black,
                                                      child: Center(
                                                        child: Text(
                                                            "Book A Schedule",
                                                            style: TextStyle(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      )),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    DateTime? selectdate =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(1990),
                                                            lastDate:
                                                                DateTime(2100));
                                                    //var time= await showTimePicker(context: context, initialTime:TimeOfDay.now() );
                                                    // print(time);
                                                    dateTime = selectdate!;
                                                    setState(() {
                                                      print(dateTime);
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: Center(
                                                      child: Text(DateFormat(
                                                              "dd-MM-yyyy")
                                                          .format(dateTime)
                                                          .toString()),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                  child: Container(
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius
                                                                    .circular(
                                                                        20))),
                                                    child: Center(
                                                        child: Text("${time.toString()}"),
                                                  ),
                                                ),),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        userid=snapshot.data!.docs[index].id;
                                                        // print("dcfvbnm");
                                                      //  print(" ${userid}");
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "booking")
                                                            .add({
                                                          "date": dateTime
                                                              .toString(),
                                                          "time": time!
                                                              .format(context)
                                                              .toString(),
                                                          "doc_id": snapshot
                                                              .data!
                                                              .docs[index]
                                                              .id,
                                                          "docname": snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .data()[
                                                              "docname"],
                                                          // "user_id":snapshot.data!.docs[index].id,
                                                          "status": "pending",
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        width: 80,
                                                        child: Center(
                                                          child: Text("Save"),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12))),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        width: 80,
                                                        child: Center(
                                                          child:
                                                              Text("Discard"),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12))),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              },
                              child: Container(
                                height: 50,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.lightGreenAccent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                  "Book Now",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return Text("");
              }
            }),
      ),
    ]));
  }
}
