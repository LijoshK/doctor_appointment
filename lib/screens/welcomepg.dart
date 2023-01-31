import 'package:doctor_appointment/screens/doctor/doc_reg.dart';
import 'package:doctor_appointment/screens/loginpg.dart';
import 'package:doctor_appointment/screens/user_patient/user_reg.dart';
import 'package:doctor_appointment/utilities/resources.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Welcomepg extends StatefulWidget {
  const Welcomepg({Key? key}) : super(key: key);

  @override
  State<Welcomepg> createState() => _WelcomepgState();
}

class _WelcomepgState extends State<Welcomepg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(9, 188, 212, 1),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.elliptical(400, 320)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Are you feeling illness?",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Positioned(
                  child: SizedBox(
                    height: 200,
                    width: 140,
                    child: Lottie.asset("assets/18017-doctor.json"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text(
              "Welcome to Doc App_ointment",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Loginpg(),
                  ));
                },
                child: Container(
                  height: 50,
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: Appresrc().colors1),
                  child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
            SizedBox(
              height: 80,
            ),
                      ],
        ),
      ),
    );
  }
}
