import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/screens/user_patient/user_homepg.dart';
import 'package:doctor_appointment/utilities/resources.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userupdtprfle extends StatefulWidget {
  // String names;
  // String emails;
  // String phnos;
  // String paswrds;
  const Userupdtprfle({Key? key}) : super(key: key);

  @override
  State<Userupdtprfle> createState() => _UserupdtprfleState();
}

class _UserupdtprfleState extends State<Userupdtprfle> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController addrss = TextEditingController();
  TextEditingController gendr = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController phno = TextEditingController();
  TextEditingController password = TextEditingController();

  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = await preferences.getString("id");
    // preferences.getString("useremail");
    // preferences.getString("userphno");
    // // preferences.getString("docpassword");
    // preferences.getString("userpassword");
    var data= await FirebaseFirestore.instance.collection("patient").doc(id).get();
    var details = await data.data();

    setState(() {
      name.text = details!["username"];
      email.text = details["useremail"];
      addrss.text = details["useraddress"];
      gendr.text = details["usergender"];
      dob.text = details["userdob"];
      phno.text = details["userphno"];
      password.text = details["userpassword"];
    });
  }

  store() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = await preferences.getString("id");
    await FirebaseFirestore.instance.collection("patient").doc(id).update({
      "username": name.text,
      "useremail": email.text,
      "userphno": phno.text,
      "userpassword": password.text
    });
    print(id);

    var logindata =  await FirebaseFirestore.instance.collection("login").get();
     logindata.docs.forEach((element)async {
     if(element.data()["id"] ==id){
       await FirebaseFirestore.instance.collection("login").doc(element.data()["id"]).update({
         "username": name.text,
         "email": email.text,
         "password": password.text
       });
     }
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
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: addrss,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: gendr,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: dob,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: phno,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await store();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Userhomepg(),
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
      ),
    );
  }
}
