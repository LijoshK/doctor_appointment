import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/screens/doctor/doc_homepg.dart';
import 'package:doctor_appointment/utilities/resources.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Docupdtprfle extends StatefulWidget {
  const Docupdtprfle({Key? key}) : super(key: key);

  @override
  State<Docupdtprfle> createState() => _DocupdtprfleState();
}

class _DocupdtprfleState extends State<Docupdtprfle> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phno = TextEditingController();
  TextEditingController password = TextEditingController();

  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = await preferences.getString("id");
    var data =
        await FirebaseFirestore.instance.collection("doctor").doc(id).get();
    var details = await data.data();

    setState(() {
      name.text = details!["docname"];
      email.text = details["docemail"];
      phno.text = details["docphno"];
      password.text=details["docpassword"];
    });
    // phno.text=phoneno.toString();
    //
  }

  store() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = await preferences.getString("id");
    await FirebaseFirestore.instance.collection("doctor").doc(id).update({
      "docname": name.text,
      "docemail": email.text,
      "docphno": phno.text,
      "docpassword": password.text
    });
    await FirebaseFirestore.instance.collection("login").doc(id).update({
      "username": name.text,
      "email": email.text,
      "password": password.text
    });
  }

  File? imageFile;
  final picker = ImagePicker();

  Future pickImage() async {
    dynamic pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      imageFile = File(pickedFile.path);
      uploader(imageFile!);
    });
  }

  Future<dynamic> uploader(File image) async {
    // String Filename = basename(imageFile.path);
    try {
      var url = await FirebaseStorage.instance
          .ref()
          .child('uploads/${image.path}')
          .putFile(image)
          .storage
          .ref()
          .getDownloadURL();
      print(url);
    } on Exception catch (e) {
      print('error');
      // TODO
    }
  }

  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Appresrc().colors1,
            // gradient: LinearGradient(colors: )
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  pickImage();
                },
                child: Stack(
                  children: [
                    Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle)),
                    Positioned(
                      top: 65,
                      left: 55,
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Name")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: phno,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Phone Number")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Password")),
                ),
              ),
              InkWell(
                onTap: () async {
                 await store();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Dochomepg(),
                  ));
                },
                child: Container(
                  height: 50,
                  width: 70,
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.white,
                    // gradient: LinearGradient(colors: )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
