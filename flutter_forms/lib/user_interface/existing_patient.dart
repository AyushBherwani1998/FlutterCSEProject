import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forms/firebase_services/firestore_search_service.dart';
import 'package:flutter_forms/firebase_services/searchByName.dart';
import 'package:flutter_forms/user_interface/dashboard_for_existing_user.dart';

class ExistingPatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Existing Patient",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ExisitingPatientBody(),
    );
  }
}

class ExisitingPatientBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExistingPatientBody();
  }
}

class _ExistingPatientBody extends State<ExisitingPatientBody> {
  var queryResultSet = [];
  var tempSearchStore = [];

  //Variables for Search
  String searchOption = "Number";
  List<DropdownMenuItem<String>> searchList = [];
  List<String> dropListSearch = ["Number", "Name"];

  bool checkList = false;
  TextEditingController forSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchList = dropListSearch
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 10.0,
          color: Colors.white,
        ),

        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              autofocus: true,
              textCapitalization: TextCapitalization,
              controller: forSearch,
              onChanged: (val) {
                //val=searchOption;
                //print(val);
                isNumeric(val)?
                startSearch(val, "Number"):
                startSearch(val, "Name");
                setState(() {
                  checkList = true;
                });
              },
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 10.0,
          color: Colors.white,
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                scrollDirection: Axis.vertical,
                children: checkList
                    ? (tempSearchStore.isNotEmpty
                        ? tempSearchStore.map((element) {
                            return buildUserCard(element);
                          }).toList()
                        : <Widget>[
                            SizedBox(
                              height: 100.0,
                            ),
                            Center(
                                child: Image(
                                    image:
                                        AssetImage("images/no_user_found.gif")))
                          ])
                    : <Widget>[Container(color: Colors.white)]),
          ),
        )
      ],
    );
  }

  void startSearch(String val, String filter) {
    if (val.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    if (queryResultSet.length == 0 && val.length == 1) {
      print("inseide search");
      print(filter);
      filter == 'Name'
          ? SearchServiceByName().searchByName(val).then((QuerySnapshot docs) {
              for (int i = 0; i < docs.documents.length; ++i) {
                setState(() {
                  queryResultSet.add(docs.documents[i].data);
                });
              }
            })
          : SearchService().searchByName(val).then((QuerySnapshot docs) {
              for (int i = 0; i < docs.documents.length; ++i) {
                setState(() {
                  queryResultSet.add(docs.documents[i].data);
                });
              }
            });
    } else {
      tempSearchStore = [];
      filter=="Number"?queryResultSet.forEach((element) {
        if (element['mobile'].startsWith(val)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      }):queryResultSet.forEach((element) {
        if (element['name'].startsWith(val)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  Widget buildUserCard(element) {
    return Card(
      elevation: 8.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
          onTap: () {
            print(element);
            forSearch.clear();
            setState(() {
              queryResultSet = [];
              tempSearchStore = [];
              checkList = false;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ExistingUserDashboard(mobile: element['mobile'])));
          },
          contentPadding: EdgeInsets.all(8.0),
          leading: Icon(
            Icons.account_circle,
            size: 56.0,
            color: getColor(),
          ),
          title: Text(
            element['name'],
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.w500),
          ),
          subtitle:
              Text(element['mobile'], style: TextStyle(color: Colors.black54))),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  MaterialColor getColor() {
    List<MaterialColor> colors = [
      Colors.blue,
      Colors.green,
      Colors.grey,
      Colors.amber,
      Colors.deepOrange
    ];
    return (colors[Random().nextInt(4)]);
  }
}
