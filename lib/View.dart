import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:todo_list/Createprofile.dart';

import 'package:todo_list/Update.dart';
import 'dart:convert';

import 'package:todo_list/alldata.dart';

class View extends StatefulWidget {
  View({Key? key}) : super(key: key);
  @override
  ViewHome createState() => ViewHome();
}

class ViewHome extends State<View> {
  bool isLoading = false;
  String error = "";

  List subList = [];

  @override
  void initState() {
// TODO: implement initState

    super.initState();

    getLeaveData();
  }

  Future<void> getLeaveData() async {
    var data = {
      "class": "",
    };
// Starting App API Call.
    var response = await http
        .post(
            Uri.parse(
                "https://khancollege.000webhostapp.com/service_hub/todo_view.php"),
            body: json.encode(data))
        .catchError((e) {
      if (e is SocketException) print("No internet connection");
      setState(() {
        error = "";
        isLoading = false;
      });
    });
// Getting Server response into variable.
    var obj = jsonDecode(response.body);

    if (obj["result"] == "S") {
      setState(() {
        error = "";
        isLoading = false;
        subList = obj["data"];
      });
    } else {
      setState(() {
        isLoading = false;
        error = "Student Class is not valid in the list";
      });
    }
  }

  Future<void> deleteUser(String id) async {
    var data = {'id': id};
    var response = await http.post(
        Uri.parse(
            "https://khancollege.000webhostapp.com/service_hub/todo_delete.php"),
        body: json.encode(data));
    var obj = jsonDecode(response.body);
    if (obj['result'] == "S") {
      Fluttertoast.showToast(
          msg: "Record Deleted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurple,
          textColor: Colors.white,
          fontSize: 16.0);
      print("Record is Deleted");

      getLeaveData();
    } else {
      print("Otherwise not Deleted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBCEBEB),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Text(
              "TODO LIST",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: subList == null ? 0 : subList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                // color: getRange(double.parse(subList[index]['Pay_Bills'])),
                child: ListTile(
                  title: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      Text(
                        "Hit_Gym :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(subList[index]["Hit_Gym"]),
                      SizedBox(
                        width: 150,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            deleteUser(subList[index]["id"].toString());
                            //  subList[index].counter = 0;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.teal,
                              borderRadius: BorderRadius.circular(0),
                              border: Border.all(color: Colors.teal),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(3),
                            child: Center(
                              child: Container(
                                child: Icon(
                                  Icons.delete_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      Text(
                        "Pay_Bill :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(subList[index]["Pay_Bill"].toString())
                    ]),
                    Row(children: [
                      Text(
                        "Buy_Eggs :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(subList[index]["Buy_Eggs"].toString())
                    ]),
                    Row(children: [
                      Text(
                        "Read_Book : ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(subList[index]["Read_Book"].toString())
                    ]),
                    Row(children: [
                      Text(
                        "Go_Office :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(subList[index]["Go_Office"].toString())
                    ]),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurple,
                                  minimumSize: const Size(130, 50)),
                              child: const Text(
                                'UPDATE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Update(
                                            subList[index]["id"].toString())));
                              }),
                        ]),
                  ]),
                  onTap: () {
                    // if (subList[index]['Pay_Bills'] != "0")
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) =>
                    //               AllData(subList[index]["id"].toString())));
                  },
                ),
              );
            },
          ))
        ],
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Createprofile()));
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
