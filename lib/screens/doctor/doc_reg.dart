import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/controllers/controllers.dart';
import 'package:doctor_appointment/screens/doctor/doc_homepg.dart';
import 'package:doctor_appointment/utilities/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Doctorreg extends StatefulWidget {
  const Doctorreg({Key? key}) : super(key: key);

  @override
  State<Doctorreg> createState() => _DoctorregState();
}

class _DoctorregState extends State<Doctorreg> {
  setprefernce(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name", txtdocname.text);
    preferences.setString("email", txtdocemail.text);
    preferences.setString("id", id);
     preferences.setString("phone", txtdocphno.text);
     preferences.setString("docspecialized", txtdocspecialize.text);
     preferences.setString("docqualification", txtdocqualifction.text);

  }

  adddocdata() async{
   var doctors = await FirebaseFirestore.instance.collection("doctor").add({
      "docname": txtdocname.text,
      "docemail": txtdocemail.text,
      "docaddress":txtdocaddress.text,
      "docphno":txtdocphno.text,
      "docspecialized": txtdocspecialize.text,
      "docqualification": txtdocqualifction.text,
      "docfees": txtdocfees.text,
      "doctimeslot": txtdoctimeslt.text,
      "docpassword": txtdocpswd.text,
    });
   var doctrid = await FirebaseFirestore.instance.collection("login").add({
         "username": txtdocname.text,
         "email": txtdocemail.text,
         "password": txtdocpswd.text,
         "type":"Doctor",
         "id":doctors.id,
  });
   setprefernce(doctors.id);
   }

  TimeOfDay? timeOfDay = TimeOfDay.now();

  final formvalidate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(134,201,217, 1),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Appresrc().colors1, Colors.white])),
          child: SingleChildScrollView(
            child: Form(
              key: formvalidate,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Register as a Doctor",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter name";
                        }
                      },
                      controller: txtdocname,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), label: Text("Name")),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email_id";
                        }
                      },
                      controller: txtdocemail,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Email_id")),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Address";
                        }
                      },
                      controller: txtdocaddress,
                      maxLines: 4,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), label: Text("Address")),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter phoneNumber";
                        }
                        if (value.length != 10) {
                          return "Check phoneNumber";
                        }
                        if(value.length>10){
                          return "Check Phone_number";
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: txtdocphno,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Phone Number")),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter What you are Specialized in ?";
                        }
                      },
                      controller: txtdocspecialize,
                      maxLines: 3,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Speciliazed in")),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Qualification";
                        }
                      },
                      controller: txtdocqualifction,
                      maxLines: 3,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Qualification")),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter How much ";
                        }
                      },
                      controller: txtdocfees,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), label: Text("Fees")),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        time = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        setState(() {
                          timeOfDay = time;
                          txtdoctimeslt.text = time!.format(context).toString();
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Time_Slots";
                        }
                      },
                      controller: txtdoctimeslt,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Time_Slots")),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        }
                      },
                      controller: txtdocpswd,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Password"),
                          suffixIcon: Icon(Icons.remove_red_eye)),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        final valid = formvalidate.currentState!.validate();
                        if (valid == true) {
                          if(txtdocemail.text.contains("@gmail.com")){
                            adddocdata();
                            // logindata();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Dochomepg(),
                            ));
                          }

                        } else {
                          return;
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            color: Appresrc().colors1),
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
