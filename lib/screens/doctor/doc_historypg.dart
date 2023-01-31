import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/utilities/resources.dart';
import 'package:flutter/material.dart';

class Docapproving extends StatefulWidget {
  const Docapproving({Key? key}) : super(key: key);

  @override
  State<Docapproving> createState() => _DocapprovingState();
}

class _DocapprovingState extends State<Docapproving> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("booking").snapshots(),
                  builder: (context,AsyncSnapshot snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context,index) {
                            return
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // height:  150,
                                  //width: 100,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(32, 93, 137, 1),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ListTile(
                                        title:  Text("Name",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        subtitle: Text(snapshot.data!.docs[index].data()["date"],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),),
                                        trailing: snapshot.data!.docs[index]["status"]=="approved" ? Container(
                                          height: 50,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              color: Colors.green),
                                          child: Center(child: Text("Approved" ,style: TextStyle(

                                            fontWeight: FontWeight.bold,)),
                                          ),
                                        ):
                                        snapshot.data!.docs[index]["status"]=="pending" ? Container(
                                          height: 50,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              color: Colors.yellow),
                                          child: Center(child: Text("Pending" ,style: TextStyle(

                                            fontWeight: FontWeight.bold,)),
                                          ),
                                        ):
                                        Container(
                                          height: 50,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              color: Colors.red),
                                          child: Center(child: Text("Rejected" ,style: TextStyle(
                                            fontWeight: FontWeight.bold,)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                          }
                      );
                    }
                    else{
                      return Text("No History");
                    }

                  }
                ),
              )
            ],
          )),
    );
  }
}
