import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/controllers/controllers.dart';
import 'package:doctor_appointment/screens/user_patient/user_homepg.dart';
import 'package:doctor_appointment/utilities/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userreg extends StatefulWidget {
  const Userreg({Key? key}) : super(key: key);

  @override
  State<Userreg> createState() => _UserregState();
}

class _UserregState extends State<Userreg> {

  adduserdata() async {
   var users = await FirebaseFirestore.instance.collection("patient").add({
      "username": txtusernm.text,
      "useremail": txtuseremail.text,
     "useraddress": txtuseraddress.text,
      "usergender": grpval.toString(),
      "userdob": dateTime.toString(),
     "userphno":txtuserphno.text,
     "userpassword":txtuserpswd.text
    });
   var data =   await FirebaseFirestore.instance.collection("login").add({
     "username": txtusernm.text,
     "email": txtuseremail.text,
     "password": txtuserpswd.text,
     "type": "User",
      "id":users.id
   });

   setprfrnc(users.id);



  }

  setprfrnc(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(" id  id   ${id}");
    preferences.setString("name", txtusernm.text);
    preferences.setString("email", txtuseremail.text);
    preferences.setString("phone", txtuserphno.text);
    preferences.setString("id", id);
  }

  DateTime? dateTime = DateTime.now();
  bool dob = false;
  String grpval = "";
  bool gender = false;
  final formvalidate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(134,201,217, 1),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Appresrc().colors1, Colors.white])),
          child: Form(
            key: formvalidate,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Title(
                      color: Colors.black,
                      child: Center(
                          child: Text(
                        "Register as a User",
                        style: TextStyle(fontSize: 30),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Name";
                        }
                      },
                      controller: txtusernm,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), label: Text("Name")),
                      keyboardType: TextInputType.text,
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
                      controller: txtuseremail,
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
                      controller: txtuseraddress,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Address"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          "Gender : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Radio(
                            value: "Male",
                            groupValue: grpval,
                            onChanged: (value) {
                              setState(() {
                                gender = true;
                                grpval = "Male";
                              });
                            }),
                        Text(
                          "Male",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Radio(
                            value: "Female",
                            groupValue: grpval,
                            onChanged: (value) {
                              setState(() {
                                gender = true;
                                grpval = "Female";
                              });
                            }),
                        Text(
                          "Female",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () async {
                        birthdate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2100));
                        setState(() {
                          dateTime = birthdate;
                          dob = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Date of Birth",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              height: 1),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(DateFormat("yyyy-MM-dd").format(dateTime!)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Phone_Number";
                        }
                        if (value.length != 10) {
                          return "Check Phone_number";
                        }
                        if(value.length>10){
                          return "Check Phone_number";
                        }
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: txtuserphno,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Phone Number")),
                      keyboardType: TextInputType.phone,
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
                      controller: txtuserpswd,
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
                      onTap: ()async {
                        final valid = await formvalidate.currentState!.validate();
                        if (valid == true || dob == true || gender == true) {
                          if(txtuseremail.text.contains("@gmail.com")){
                            // logindata();
                            adduserdata();
                            setprfrnc(userid);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Userhomepg(),
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
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
