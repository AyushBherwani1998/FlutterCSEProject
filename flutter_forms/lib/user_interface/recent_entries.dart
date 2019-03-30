import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forms/user_interface/recent_patient.dart';

class RecentEntryActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recent Entries",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: RecentEntryBody(),
    );
  }
}

class RecentEntryBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecentEntryBody();
  }
}

class _RecentEntryBody extends State<RecentEntryBody> {
  var recentEntriesList = [];
  var documentsList = [];
  @override
  void initState() {
    super.initState();
    getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return recentEntriesList!=null?
    Container(
      color: Colors.white70,
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: recentEntriesList.length, //no. of recent forms,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),

            child: Padding(padding: EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RecentPatientActivity(userId: recentEntriesList[index]['user id'],)));
              },
              title: Text(recentEntriesList[index]['name'].toString(),
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400)),
              //give name of form
              subtitle: Text("Form: "+recentEntriesList[index]['form']+"\nScore: ${recentEntriesList[index]['score']!=null?recentEntriesList[index]['score'].toString():
              ""}",
                  style: TextStyle(color: Colors.black54)),
              //add score and date
              trailing: Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                    color: getScoreColor(recentEntriesList[index]['score']),
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
              )),)
          );
        },
      ),
    ):
    Container(color: Colors.green,child: Text('Null'),);
  }

  MaterialColor getScoreColor(int score) {
    if (score < 10)
      return Colors.green;
    else if (score > 10 && score < 30)
      return Colors.yellow;
    else
      return Colors.red;
  }

  Future<void> getDocuments() async{
    await Firestore.instance
        .collection('recent_entries')
        .getDocuments()
        .then((QuerySnapshot docs) {
      documentsList = docs.documents;
      for (int i = 0; i < documentsList.length; i++) {
        setState(() {
          recentEntriesList.add(documentsList[i].data);
        });
        print(recentEntriesList);
      }
    });
  }
}
