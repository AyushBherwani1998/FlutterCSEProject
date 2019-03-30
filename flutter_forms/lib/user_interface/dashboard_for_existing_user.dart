import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forms/forms/epds_form.dart';
import 'package:flutter_forms/forms/pbq_form.dart';
class ExistingUserDashboard extends StatelessWidget{
  final String mobile;
  ExistingUserDashboard({this.mobile});
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
      body: ExistingPatientDashboardBody(mobile: mobile,),
    );
  }

}

class ExistingPatientDashboardBody extends StatefulWidget{
  final String mobile;
  ExistingPatientDashboardBody({this.mobile});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExistingPatientDashboardBody(mobile: mobile);
  }
}

class _ExistingPatientDashboardBody extends State<ExistingPatientDashboardBody>{
  final String mobile;
  String uid;
  _ExistingPatientDashboardBody({this.mobile});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firestore.instance
        .collection('user')
        .where('mobile',
        isEqualTo: mobile)
        .getDocuments().then((QuerySnapshot docs){
          setState(() {
            uid = docs.documents[0].documentID.toString();
          });
         print(docs.documents[0].documentID);
        });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(3.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            Card(
              elevation: 4.0,
              color: Colors.blueAccent,
              child: ListTile(
                onTap: (){
                  print("New EPDS Form");
                  print(uid);
                  _getEDPSScore(uid,context);
                },
                contentPadding: EdgeInsets.all(14.0),
                title: Text("EPDS Form",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                trailing: IconButton(icon: Icon(Icons.add,color: Colors.white,),onPressed: (){print("New EPDS Form");
                _getEDPSScore(uid,context);
                },),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Card(
              elevation: 4.0,
              color: Colors.blueAccent,
              child: ListTile(
                onTap: (){
                  print("New PBQ Form");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PBQForm()));
                },
                contentPadding: EdgeInsets.all(14.0),
                title: Text("PBQ Form",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                trailing: IconButton(icon: Icon(Icons.add,color: Colors.white,),onPressed: (){print("New PBQ Form");
                Navigator.pop(context);
                },),
              ),
            )
          ],
        )
    );
  }

  void _getEDPSScore(String uid, BuildContext context)async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>EPDS(uid: uid)));
    if(result!=null){
      showDialog(context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("EPDS Response Recorded"),
              content:Text("Your EPDS Score is $result"),
              actions: <Widget>[
                FlatButton(child:Text("Okay"), onPressed: () {
                  print("Pressed Okay, Dismiss Alert Dialog");
                  Navigator.pop(context);
                },)
              ],
            );
          });
    }
  }
}