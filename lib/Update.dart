import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/View.dart';

class Update extends StatefulWidget {
  String id = '';
  Update(String id) {
    this.id = id;
  }

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  TextEditingController Hit_Gym = new TextEditingController();
  TextEditingController Buy_Eggs = new TextEditingController();
  TextEditingController Pay_Bill = new TextEditingController();
  TextEditingController Read_Book = new TextEditingController();
  TextEditingController Go_Office = new TextEditingController();

  String error = "";
  bool isLoading = false;
  // List<UpdateCat> p = [];
  List? data;
  List subList = [];
  Future<void> getid(String id) async {
    var data = {
      "id": id,
    };
// Starting App API Call.
    var response = await http
        .post(
            Uri.parse(
                "https://khancollege.000webhostapp.com/service_hub/todo_exist_id.php"),
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
        log(subList.toString());
        Hit_Gym.text = subList[0]['Hit_Gym'];
        Pay_Bill.text = subList[0]['Pay_Bill'];
        Buy_Eggs.text = subList[0]['Buy_Eggs'];
        Read_Book.text = subList[0]['Read_Book'];
        Go_Office.text = subList[0]['Go_Office'];
      });

      // subList[0]['id'];
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => AllData(widget.id)));
    } else {
      setState(() {
        isLoading = false;
        error = "Student Class is not valid in the list";
      });
      // SizedBox();
    }
  }

  void initState() {
    getid(widget.id);
    log("ID :${widget.id}");
// TODO: implement initState
    super.initState();
  }

  Future<void> UpdateUser() async {
    var data = {
      'id': widget.id,
      'Hit_Gym': Hit_Gym.text.toString(),
      'Pay_Bill': Pay_Bill.text.toString(),
      'Buy_Eggs': Buy_Eggs.text.toString(),
      'Read_Book': Read_Book.text.toString(),
      'Go_Office': Go_Office.text.toString(),
    };
    var response = await http.post(
        Uri.parse(
            "https://khancollege.000webhostapp.com/service_hub/todo_update.php"),
        body: json.encode(data));
    var obj = jsonDecode(response.body);
    log(data.toString());
    if (obj['result'] == "S") {
      Fluttertoast.showToast(
          msg: "Update Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurple,
          textColor: Colors.white,
          fontSize: 16.0);
      print("Record is Saved");
      Navigator.push(context, MaterialPageRoute(builder: (context) => View()));
    } else {
      print("Record is not Saved");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50),
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          children: <Widget>[
            const SizedBox(
              height: 30,
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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    minimumSize: const Size(330, 50)),
                child: const Text(
                  'UPDATE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                onPressed: () {
                  UpdateUser();
                  setState(() {
                    isLoading = true;
                    //PicInsert();
                    // Update();
                  });
                }),
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
