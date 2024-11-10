import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user_registration/models/user_model.dart';

class RegistrationPage extends StatelessWidget {
  MediaQueryData? mqData;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final user = UserModel(
          name: nameController.text.toString(),
          email: emailController.text.toString(),
          phone: phoneController.text.toString(),
          gender: genderController.text.toString()).toMap();
      //Add Data in SQFlite here


    }
  }

  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Registration Page",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 15,),
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
                      "Name", style: TextStyle(fontWeight: FontWeight.bold),),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: emailController,
                validator: (value) =>
                !RegExp(r'^[\w\-.]+@[a-zA-Z0-9.]+\.[a-zA-Z]{2,4}$').hasMatch(
                    value!)
                    ? 'Enter a valid email'
                    : null,
                decoration: InputDecoration(
                    hintText: "Enter Your Email",
                    label: Text(
                      "Email", style: TextStyle(fontWeight: FontWeight.bold),),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty
                    ? 'Enter your phone number'
                    : null,
                decoration: InputDecoration(
                    hintText: "Enter Your Phone Number",
                    label: Text(
                      "Number", style: TextStyle(fontWeight: FontWeight.bold),),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: genderController,
                validator: (value) =>
                value!.isEmpty
                    ? 'Enter your gender'
                    : null,
                decoration: InputDecoration(
                    hintText: "Enter Your Gender",
                    label: Text(
                      "Gender", style: TextStyle(fontWeight: FontWeight.bold),),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.shade100,
                      minimumSize: Size(mqData!.size.width * 1, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  onPressed: () {
                    _saveForm();
                  },
                  child: Text("Submit Data",
                    style: TextStyle(color: Colors.black, fontSize: 17),))
            ],
          ),
        ),
      ),
    );
  }
}