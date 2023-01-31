import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/utilities/resources.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Docbookingpg extends StatefulWidget {
  const Docbookingpg({Key? key}) : super(key: key);

  @override
  State<Docbookingpg> createState() => _DocbookingpgState();
}

class _DocbookingpgState extends State<Docbookingpg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 110,
                width: 200,
                child: Lottie.asset("assets/110260-online-doctor.json"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Title(
                    color: Colors.black,
                    child: Text("Booking_Requests",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("booking").snapshots(),
                    builder: (context,snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return CircularProgressIndicator();
                      }
                      if(snapshot.hasData){
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                snapshot.data!.docs[index]["status"]=="pending" ? Container(
                                  height: 150,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(32, 93, 137, 1),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(snapshot.data!.docs[index].data()["date"],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      Text(snapshot.data!.docs[index].data()["time"],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child:
                                            Container(
                                              height: 50,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(12),
                                                  ),
                                                  color: Colors.green),
                                              child: Center(
                                                child: InkWell(
                                                    onTap: () async {
                                                      docid = snapshot.data!.docs[index].id;
                                                      print(docid);

                                                      await FirebaseFirestore.instance.collection("booking").doc(docid).update({"status":"approved"});
                                                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Loginpg(),));
                                                    },
                                                    child: Text(
                                                      "Approve",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Container(
                                              height: 50,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(12),
                                                  ),
                                                  color: Colors.redAccent),
                                              child: Center(
                                                child: InkWell(
                                                    onTap: () async {
                                                      docid=snapshot.data!.docs[index].id;
                                                      await FirebaseFirestore.instance.collection("booking").doc(docid).update({"status":"rejected"});
                                                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Loginpg(),));
                                                    },
                                                    child: Text(
                                                      "Reject",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ):snapshot.data!.docs[index]["status"]=="approved"?
                                Container(
                                  height: 150,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(32, 93, 137, 1),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(snapshot.data!.docs[index].data()["date"],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      Text(snapshot.data!.docs[index].data()["time"],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.all(10),
                                              child:
                                              Container(
                                                height: 50,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(12),
                                                    ),
                                                    color: Colors.green),
                                                child: Center(
                                                  child: Text(
                                                    "Approved",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ):Container()
                            );
                          },
                        );
                      }
                      return Text("");
                    }
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Title(
              //       color: Colors.black,
              //       child: Text("Approved_Schedules",
              //           style: TextStyle(
              //               fontSize: 25, fontWeight: FontWeight.bold))),
              // ),
              // Container(
              //   height: 70,
              //   child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: 6,
              //       itemBuilder: (context, index) {
              //         return Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Container(
              //             height: 80,
              //             width: 100,
              //             decoration: BoxDecoration(
              //                 color: Appresrc().colors1,
              //                 borderRadius:
              //                     BorderRadius.all(Radius.circular(8))),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Text("Name"),
              //                 Text("Time"),
              //               ],
              //             ),
              //           ),
              //         );
              //       }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
