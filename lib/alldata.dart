import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:todo_list/Update.dart';

class AllData extends StatefulWidget {
  String id = '';
  AllData(String id) {
    this.id = id;
  }
  @override
  AllDataAllData createState() => AllDataAllData();
}

class AllDataAllData extends State<AllData> {
  bool isLoading = false;
  String error = "";

  List subList = [];

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    log("plz print");
    getid(widget.id);
  }

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
// Future<void> update() async{
//     var data = {
//       'id':id.text.toString(),
//       'book':Hit_Gym.text.toString(),
//       'writer':writer.text.toString(),
//       'edition':edition.text.toString(),

//     };
//     var response = await http.post(
//         Uri.parse(
//             "https://projmy.000webhostapp.com/miniproject_book/updatebook.php"),
//         body: json.encode(data));
//     var obj = jsonDecode(response.body);
//     if (obj['result'] == "S") {
//       print("Record is Updated");
//     }
//     else {
//       print("Record is not Updated");
//     }
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFBCEBEB),
        body: Column(
          children: <Widget>[
            Text("cjklawhefk;awhf"),
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
                        Text(subList[0]["Hit_Gym"] + "       id  " + widget.id)
                      ]),
                      Row(children: [
                        Text(
                          "Pay_Bill :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(subList[0]["Pay_Bill"])
                      ]),
                      Row(children: [
                        Text(
                          "Buy_Eggs :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(subList[0]["Buy_Eggs"].toString())
                      ]),
                      Row(children: [
                        Text(
                          "Read_Book : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(subList[0]["Read_Book"].toString())
                      ]),
                      Row(children: [
                        Text(
                          "Go_Office :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(subList[0]["Go_Office"].toString())
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                );
              },
            ))
          ],
        ));
  }
}
