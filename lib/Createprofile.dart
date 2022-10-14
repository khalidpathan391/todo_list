import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:todo_list/View.dart';

class Createprofile extends StatefulWidget {
  State<Createprofile> createState() => _CreateprofileState();
}

class _CreateprofileState extends State<Createprofile> {
  TextEditingController Hit_Gym = new TextEditingController();
  TextEditingController Buy_Eggs = new TextEditingController();
  TextEditingController Pay_Bill = new TextEditingController();
  TextEditingController Read_Book = new TextEditingController();
  TextEditingController Go_Office = new TextEditingController();

  String error = "";
  bool isLoading = false;
  // List<CreateprofileCat> p = [];
  List? data;

  Future<void> Add() async {
    var data = {
      'Hit_Gym': Hit_Gym.text.toString(),
      'Pay_Bill': Pay_Bill.text.toString(),
      'Buy_Eggs': Buy_Eggs.text.toString(),
      'Read_Book': Read_Book.text.toString(),
      'Go_Office': Go_Office.text.toString(),
    };
    var response = await http.post(
        Uri.parse(
            "https://khancollege.000webhostapp.com/service_hub/todo_add.php"),
        body: json.encode(data));
    var obj = jsonDecode(response.body);
    log(data.toString());
    if (obj['result'] == "S") {
      print("Record is Saved");
      Fluttertoast.showToast(
          msg: "Saved Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurple,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print("Record is not Saved");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            const Text(
              "PROFILE DETAILS",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.deepPurple),
            ),
            const Text(
              "Give us few details about yourself",
              style: TextStyle(fontSize: 15),
            ),
            const Text(
              "to create your Profile",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: Hit_Gym,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Hit_Gym',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: Pay_Bill,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.home,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Pay_Bill',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: Buy_Eggs,
              // keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.phone_android,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Buy_Eggs',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: Read_Book,
              // keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Read_Book',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: Go_Office,
              //  keyboardType: TextInputType.,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.messenger,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Go_Office',
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      minimumSize: const Size(150, 50)),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //     context,MaterialPageRoute(builder:(context)=> SelectDeliveryLocation())
                    setState(() {
                      isLoading = true;
                      //PicInsert();
                      Add();
                      // EasyLoading.show(status: 'Add Data...');
                    });
                  }),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      minimumSize: const Size(150, 50)),
                  child: const Text(
                    'View',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => View()));
                    setState(() {
                      isLoading = true;
                      //PicInsert();
                      // Add();
                      // EasyLoading.show(status: 'Add Data...');
                    });
                  }),
            ]),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => View()));
                },
                child: Icon(Icons.home, color: Colors.blue.shade900)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Icon(Icons.people, color: Colors.blue.shade900)),
            label: '',
          ),
        ],
      ),
    );
  }
}
