import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forms/firebase_services/firestore_search_service.dart';
import 'package:flutter_forms/firebase_services/firebase_auth.dart';
import 'package:flutter_forms/user_interface/recent_patient.dart';
class RecentE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent Entries",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Recent(),
    );
  }
}
class Recent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RecentPatient();
  }

}
class RecentPatient extends State<Recent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: 5, //no. of recent forms,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.blue,
            elevation: 10.0,
            child: ListTile(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>RecentP()));},
              isThreeLine: true,
              title: Text(
                "Name of Patient: ",
              ),
              //give name of form
              subtitle: Text("Action Required: \n"),
              //add score and date
              trailing: IconButton(
                  icon: Icon(Icons.album),
                  onPressed: null), // give color on the basis of score
            ),
          );
        },
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
