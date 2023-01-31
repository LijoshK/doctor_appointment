import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/screens/doctor/doc_homepg.dart';
import 'package:doctor_appointment/screens/doctor/doc_reg.dart';
import 'package:doctor_appointment/screens/user_patient/user_homepg.dart';
import 'package:doctor_appointment/screens/user_patient/user_reg.dart';
import 'package:doctor_appointment/utilities/resources.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpg extends StatefulWidget {
  const Loginpg({Key? key}) : super(key: key);

  @override
  State<Loginpg> createState() => _LoginpgState();
}

class _LoginpgState extends State<Loginpg> {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpswd = TextEditingController();
  dynamic usertype;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Appresrc().colors1, Colors.white])),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 140,
                      child: Lottie.asset("assets/18017-doctor.json"),
                    ),
                    Title(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: 340,
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: txtemail,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: 340,
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: txtpswd,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                suffixIcon: Icon(Icons.remove_red_eye_sharp)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () async {
                          var logdata = await FirebaseFirestore.instance
                              .collection("login")
                              .get();
                          logdata.docs.forEach((element) async{
                           var emailid = element.data()["email"];
                            // print(email);
                            var password = element.data()["password"];
                            // print(password);
                            if (emailid == txtemail.text &&
                                password == txtpswd.text) {

                              setState(() {
                                usertype = element.data()["type"];
                                uname=element.data()["email"];
                                usrname= element.data()["username"];

                              });
                              try {
                                if (element.data()["type"] == "User") {
                                  SharedPreferences prefernc = await SharedPreferences.getInstance();
                                  prefernc.setString("id",element.data()["id"]);
                                  prefernc.setString("type","User");
                                  prefernc.setString("email",element.data()["email"]);
                                  prefernc.setString("name",element.data()["username"]);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Userhomepg(),
                                  ));
                                }
                                if (element.data()["type"] == "Doctor") {
                                  SharedPreferences prefernc = await SharedPreferences.getInstance();
                                  prefernc.setString("id",element.data()["id"]);
                                  prefernc.setString("type","Doctor");
                                  prefernc.setString("docemailid",element.data()["email"]);
                                  prefernc.setString("username",element.data()["username"]);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Dochomepg(),
                                  ));
                                }
                              } catch (e) {}
                            }
                          });
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
                              "Login",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Are you new to here ? ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                            onTap: () async {
                              return showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18))),
                                  title: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Register as "),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Userreg()));
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 140,
                                            decoration: BoxDecoration(
                                              color: Appresrc().colors1,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                            ),
                                            child: Center(child: Text("User")),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => Doctorreg(),
                                            ));
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 140,
                                            decoration: BoxDecoration(
                                              color: Appresrc().colors1,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                            ),
                                            child:
                                                Center(child: Text("Doctor")),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "Register now",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
