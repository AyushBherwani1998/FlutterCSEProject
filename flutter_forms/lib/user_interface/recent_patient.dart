import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecentPatientActivity extends StatelessWidget {
  final String userId;
  RecentPatientActivity({this.userId});
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
      body: RecentPatientBody(userId: userId),
    );
  }
}

class RecentPatientBody extends StatefulWidget {
  final String userId;
  RecentPatientBody({this.userId});
  @override
  State<StatefulWidget> createState() {
    return _RecentPatientBody(userId: userId);
  }
}

class _RecentPatientBody extends State<RecentPatientBody> {
  final String userId;
  var userDetails;
  var getEPDSDocs=[];
  var getSocialDemographyDoc=[];
  var getEPDSList=[];
  _RecentPatientBody({this.userId});
  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('user').document(userId).get().then((DocumentSnapshot doc){
      if(doc!=null){
        setState(() {
          userDetails = doc.data;
        });
      }
      print(userDetails);
    });
    Firestore.instance.collection('user').document(userId).collection('epds_responses').getDocuments().then((QuerySnapshot docs){
      getEPDSDocs = docs.documents;
      for(int i=0;i<getEPDSDocs.length;i++){
        setState(() {
          getEPDSList.add(getEPDSDocs[i].data);
        });
      }
      print(getEPDSList);

    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey.shade300,
          padding: EdgeInsets.all(10.0),
          child: Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  title: Text('Name:${userDetails==null?"":userDetails['name']}',style: TextStyle(fontSize: 22.0)),
                  subtitle:
                  Text(
                      '\nNo. of PBQ forms: ${userDetails==null?"":userDetails['pbq_count']}\nNo. of EPDS forms: ${userDetails==null?"":userDetails['epds_count']}'),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: 10, //no. of recent forms,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 15.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                  color: Colors.white,
                  child: ListTile(
                    isThreeLine: true,
                    title: Text(
                      "Type of form: ",
                    ),
                    //give name of form
                    subtitle: Text("Score:  \nDate:dd/mm/yy "),
                    //add score and date
                    trailing: IconButton(
                        icon: Icon(Icons.album,color: Colors.yellow,),
                        onPressed: null), // give color on the basis of score
                  ),
                );
              },
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
            ),
          ),
        ),
      ],
    );
  }
}
