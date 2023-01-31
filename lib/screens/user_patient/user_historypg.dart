import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Userhistorypg extends StatefulWidget {
  const Userhistorypg({Key? key}) : super(key: key);

  @override
  State<Userhistorypg> createState() => _UserhistorypgState();
}

class _UserhistorypgState extends State<Userhistorypg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("booking")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
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
                                  ListTile(
                                    title:
                                    Text(snapshot.data.docs[index]["docname"]),
                                    subtitle:
                                    Text(snapshot.data.docs[index]["time"]),
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
                    return Column(
                      children: [
                        SizedBox(height: 250,),
                        Center(child: Text("No History",style: TextStyle(fontWeight: FontWeight.bold),)),
                      ],
                    );
                  }

                }),
          )
        ],
      ),
    );
  }
}
