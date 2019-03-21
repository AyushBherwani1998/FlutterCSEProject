import 'package:flutter/material.dart';
import 'package:flutter_forms/forms/pbq_form.dart';
import 'package:flutter_forms/forms/epds_form.dart';
import 'package:flutter_forms/forms/updated_social_demography_form.dart';

class NewPatientActivity extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "New Patient",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: NewPatientBody(),
    );
  }

}

class NewPatientBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewPatientBody();
  }
}

class _NewPatientBody extends State<NewPatientBody>{
  String uid;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(3.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 8.0,),
            Card(
              elevation: 4.0,
              color: Colors.blueAccent,
              child: ListTile(
                onTap: (){
                  print("New Social Demography Form");
                  _getUserId(context);
                },
                contentPadding: EdgeInsets.all(14.0),
                title: Text("Social Demography Form",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                trailing: IconButton(icon: Icon(Icons.add,color: Colors.white,),onPressed: (){print("New Social Demography Form");
               _getUserId(context);
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
                  print("New EPDS Form");
                  print(uid);
                  uid!=null?_getEPDSScore(uid,context):showAlertDialog();
                },
                contentPadding: EdgeInsets.all(14.0),
                title: Text("EPDS Form",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                trailing: IconButton(icon: Icon(Icons.add,color: Colors.white,),onPressed: (){print("New EPDS Form");
                uid!=null?_getEPDSScore(uid,context): showAlertDialog();
                }),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PBQForm(uid: uid,)));
                },
                contentPadding: EdgeInsets.all(14.0),
                title: Text("PBQ Form",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                trailing: IconButton(icon: Icon(Icons.add,color: Colors.white,),onPressed: (){print("New PBQ Form");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PBQForm(uid: uid,)));
                },),
              ),
            )
          ],
        )
    );
  }

  _getUserId(BuildContext context)async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>SocialDemoFormActivity()));
    if(result!=null){
      setState(() {
        uid = result.toString();
      });
    }
  }
  void _getEPDSScore(String uid,BuildContext context)async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>EPDS(uid: uid,)));
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

  showAlertDialog() {
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Alert"),
            content:Text("First Fill the Social Demography Form"),
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