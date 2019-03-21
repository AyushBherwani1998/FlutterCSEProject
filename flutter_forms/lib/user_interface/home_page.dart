import 'package:flutter/material.dart';
import 'package:flutter_forms/firebase_services/firebase_auth.dart';
import 'package:flutter_forms/user_interface/existing_patient.dart';
import 'package:flutter_forms/user_interface/new_patient.dart';
import 'package:flutter_forms/user_interface/recent_entries.dart';



class Home extends StatefulWidget {
  Home({this.userId, this.auth, this.onSignedOut});

  final String userId;
  final VoidCallback onSignedOut;
  final FireBaseAuth auth;

  @override
  State<StatefulWidget> createState() {
    return MyHome();
  }

}

class MyHome extends State<Home> {
  //SignOut Method
  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Dashboard",
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text("Demo App"),
              ),
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Recent Entries'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RecentE()));
                print("Recent Entries");
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                _signOut();
              },
            ),
          ],
        ),
      ),
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyHomePage();
  }
}

class MyHomePage extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPatientActivity()));
                print("New Patient");
              },
              contentPadding: EdgeInsets.all(14.0),
              title: Text("New Patient",style: TextStyle(color: Colors.white,fontSize: 16.0),),
               trailing: IconButton(icon: Icon(Icons.add,color: Colors.white,),onPressed: (){print("New Patient");
               Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPatientActivity()));
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
                print("New Form");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ExistingPatient()));
              },
              contentPadding: EdgeInsets.all(14.0),
              title: Text("Existing Patient",style: TextStyle(color: Colors.white,fontSize: 16.0),),
              trailing: IconButton(icon: Icon(Icons.add,color: Colors.white,),onPressed: (){
                print("New Form");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ExistingPatient()));
              },),
            ),
          )
        ],
      )
    );
  }

}