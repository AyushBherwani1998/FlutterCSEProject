import 'package:flutter/material.dart';
import 'package:flutter_forms/forms/pbq_form.dart';
import 'package:flutter_forms/forms/social_demography_form.dart';
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SocialDemoFormActivity()));
                },
                contentPadding: EdgeInsets.all(14.0),
                title: Text("Social Demography Form",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                trailing: IconButton(icon: Icon(Icons.add,color: Colors.white,),onPressed: (){print("New Social Demography Form");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SocialDemoFormActivity()));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EPDS()));
                },
                contentPadding: EdgeInsets.all(14.0),
                title: Text("EPDS Form",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                trailing: IconButton(icon: Icon(Icons.add,color: Colors.white,),onPressed: (){print("New EPDS Form");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EPDS()));
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PBQForm()));
                },),
              ),
            )
          ],
        )
    );
  }
}