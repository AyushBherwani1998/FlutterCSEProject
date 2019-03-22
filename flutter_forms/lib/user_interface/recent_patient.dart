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
          color: Colors.grey.shade200,
          padding: EdgeInsets.all(10.0),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.album),
                  title: Text('\n\nName:${userDetails['name']==null?"":userDetails['name']}'),
                  subtitle: Text(
                      'No. of PBQ forms: ${userDetails['pbq_count']==null?"":userDetails['pbq_count']}\nNo. of EPDS forms: ${userDetails['epds_count']==null?"":userDetails['epds_count']}'),
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
              itemCount: 5, //no. of recent forms,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.blue,
                  elevation: 10.0,
                  child: ListTile(
                    isThreeLine: true,
                    title: Text(
                      "Type of form: PBQ",
                    ),
                    //give name of form
                    subtitle: Text("Score: 5 \nDate:dd/mm/yy "),
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
          ),
        ),
      ],
    );
  }
}
