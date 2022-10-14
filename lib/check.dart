import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class check extends StatefulWidget {
  const check({Key? key}) : super(key: key);
  @override
  checkcheck createState() => checkcheck();
}

class checkcheck extends State<check> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFBCEBEB),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              itemCount: subList == null ? 0 : subList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
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
                        Text(subList[index]["Hit_Gym"])
                      ]),
                      Row(children: [
                        Text(
                          "Pay_Bill :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(subList[index]["Pay_Bill"])
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
                        height: 20,
                      )
                    ]),
                    onTap: () {
                      // subList[index]["fee"] != 0 ? getFee() : SizedBox();

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Screen4()));
                    },
                  ),
                );
              },
            ))
          ],
        ));
  }
}
