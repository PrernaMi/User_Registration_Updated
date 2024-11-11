import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user_registration_api/data/remote/api_helper.dart';
import 'package:user_registration_api/screens/offline/offline_data.dart';

import '../data/local/db_helper.dart';
import '../models/user_model.dart';

class RegistrationPage extends StatelessWidget {
  MediaQueryData? mqData;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  DbHelper? mainDb;
  ApiHelper? apiHelper;

  void _saveForm() async {
    final Connectivity connectivity = Connectivity();

    mainDb = DbHelper.getInstance;

    final user = UserModel(
        name: nameController.text.toString(),
        email: emailController.text.toString(),
        phone: phoneController.text.toString(),
        gender: genderController.text.toString());

    connectivity.onConnectivityChanged.listen((event) async {
      var connectivityStatus = await Connectivity().checkConnectivity();
      if (connectivityStatus == ConnectivityResult.mobile ||
          connectivityStatus == ConnectivityResult.wifi) {
        await apiHelper!.postApi(
            url: "https://673034d566e42ceaf15faac7.mockapi.io/users",
            mBody: user.toMap());
      } else {
        await mainDb!.addInDb(newUser: user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Registration Page",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 3) {
                        return 'Name must be at least 3 characters long';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter Your name",
                        label: Text(
                          "Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) =>
                        !RegExp(r'^[\w\-.]+@[a-zA-Z0-9.]+\.[a-zA-Z]{2,4}$')
                                .hasMatch(value!)
                            ? 'Enter a valid email'
                            : null,
                    decoration: InputDecoration(
                        hintText: "Enter Your Email",
                        label: Text(
                          "Email",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Enter your phone number' : null,
                    decoration: InputDecoration(
                        hintText: "Enter Your Phone Number",
                        label: Text(
                          "Number",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: genderController,
                    validator: (value) =>
                        value!.isEmpty ? 'Enter your gender' : null,
                    decoration: InputDecoration(
                        hintText: "Enter Your Gender",
                        label: Text(
                          "Gender",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade100,
                          minimumSize: Size(mqData!.size.width * 1, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () {
                        _saveForm();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Data Added Successfully..")));
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return OfflineData();
                        }));
                      },
                      child: Text(
                        "Submit Data",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade100,
                          minimumSize: Size(mqData!.size.width * 1, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return OfflineData();
                        }));
                      },
                      child: Text(
                        "Already Registered?",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
