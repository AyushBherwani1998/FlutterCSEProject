import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class PBQForm extends StatelessWidget{
  final String uid;
  PBQForm({this.uid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("PBQ FORM",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: PBQFormPage(uid: uid),
    );
  }

}

class PBQFormPage extends StatefulWidget{
  final String uid;
  PBQFormPage({this.uid});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyPBQPage(uniqueId: uid);
  }
}

class MyPBQPage extends State<PBQFormPage>{

  String question1;
  List<DropdownMenuItem<String>> questionList = [];
  List<String> dropListques = ["Always","Very Often","Quite Often","Sometimes","Rarely","Never"];
  String question2;
  String question3;
  String question4;
  String question5;
  String question6;
  String question7;
  String question8;
  String question9;
  String question10;
  String question11;
  String question12;
  String question13;
  String question14;
  String question15;
  String question16;
  String question17;
  String question18;
  String question19;
  String question20;
  String question21;
  String question22;
  String question23;
  String question24;
  String question25;
  Color color1;
  Color color2;
  Color color3;
  Color color4;
  Color color5;
  Color color6;
  Color color7;
  Color color8;
  Color color9;
  Color color10;
  Color color11;
  Color color12;
  Color color13;
  Color color14;
  Color color15;
  Color color16;
  Color color17;
  Color color18;
  Color color19;
  Color color20;
  Color color21;
  Color color22;
  Color color23;
  Color color24;
  Color color25;
  List<int> scores = List(25);
  int response_count = 0;
  DocumentReference documentReference;
  StreamSubscription<DocumentSnapshot> subscription;
  final String uniqueId;

  MyPBQPage({this.uniqueId});

  int getScore(String ans){
    switch (ans){
      case "Always":
        return 0;
      case "Very Often":
        return 1;
      case "Quite Often":
        return 2;
      case "Sometime":
        return 3;
      case "Rarely":
        return 4;
      case "Never":
        return 5;
    }
  }
  int getScoreRev(String ans){
    switch (ans){
      case "Always":
        return 5;
      case "Very Often":
        return 4;
      case "Quite Often":
        return 3;
      case "Sometime":
        return 2;
      case "Rarely":
        return 1;
      case "Never":
        return 0;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionList = dropListques.map((val)=> new DropdownMenuItem(child: new Text(val),value: val,)).toList();
    color1 = Colors.red;
    color2 = Colors.red;
    color3 = Colors.red;
    color4 = Colors.red;
    color5 = Colors.red;
    color6 = Colors.red;
    color7 = Colors.red;
    color8 = Colors.red;
    color9 = Colors.red;
    color10 = Colors.red;
    color11 = Colors.red;
    color12 = Colors.red;
    color13 = Colors.red;
    color14 = Colors.red;
    color15 = Colors.red;
    color16 = Colors.red;
    color17 = Colors.red;
    color18 = Colors.red;
    color19 = Colors.red;
    color20 = Colors.red;
    color21 = Colors.red;
    color22 = Colors.red;
    color23 = Colors.red;
    color24 = Colors.red;
    color25 = Colors.red;
    question1 = null;
    question2 = null;
    question3 = null;
    question4 = null;
    question5 = null;
    question6 = null;
    question7 = null;
    question8 = null;
    question9 = null;
    question10 = null;
    question11 = null;
    question12 = null;
    question13 = null;
    question14 = null;
    question15 = null;
    question16 = null;
    question17 = null;
    question18 = null;
    question19 = null;
    question20 = null;
    question21 = null;
    question22 = null;
    question23 = null;
    question24 = null;
    question25 = null;
    documentReference = Firestore.instance.collection('user').document('$uniqueId');
    subscription = documentReference.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          if(snapshot.data['pbq_count'].toString()!=null){
            response_count = snapshot.data['pbq_count'];
          }
        });
      }
    });
    print(uniqueId);
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I feel close to my baby",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color1,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question1,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question1 = value;
                        color1 = Colors.grey;
                        scores[0] = getScore(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I wish the old days when I had no baby would come back",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color2,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question2,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question2 = value;
                        color2 =  Colors.grey;
                        scores[1] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I feel distant from my baby",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color3,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question3,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question3 = value;
                        color3 =  Colors.grey;
                        scores[2] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I love to cuddle my baby",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color4,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question4,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question4 = value;
                        color4 =  Colors.grey;
                        scores[3] = getScore(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I regret having this baby",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color5,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question5,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question5 = value;
                        color5 =  Colors.grey;
                        scores[4] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "The baby doesn't seem to be mine",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color6,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question6,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question6 = value;
                        color6 =  Colors.grey;
                        scores[5] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "My baby winds me up",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color7,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question7,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question7 = value;
                        color7 =  Colors.grey;
                        scores[6] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I love my baby to bits",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color8,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question8,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question8 = value;
                        color8 =  Colors.grey;
                        scores[7] = getScore(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I feel happy when my baby laughs or smile",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color9,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question9,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question9 = value;
                        color9 =  Colors.grey;
                        scores[8] = getScore(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "My baby irritates me",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color10,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question10,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question10 = value;
                        color10 =  Colors.grey;
                        scores[9] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I enjoy playing with my baby",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color11,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question11,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question11 = value;
                        color11 =  Colors.grey;
                        scores[10] = getScore(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "My baby cries too much",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color12,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question12,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question12 = value;
                        color12 =  Colors.grey;
                        scores[11] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I feel trapped as mother",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color13,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question13,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question13 = value;
                        color13 = Colors.grey;
                        scores[12] = getScoreRev(value);
                        });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I feel angry with my baby",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color14,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question14,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question14 = value;
                        color14 = Colors.grey;
                        scores[13] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I resent my baby",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color15,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question15,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question15 = value;
                        color15 = Colors.grey;
                        scores[14] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "My baby is the most beautiful baby in the world",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color16,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question16,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question16 = value;
                        color16 = Colors.grey;
                        scores[15] = getScore(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I wish my baby somehow would go away",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color17,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question17,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question17 = value;
                        color17 = Colors.grey;
                        scores[16] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I have done harmful things to my baby",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color18,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question18,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question18 = value;
                        color18 = Colors.grey;
                        scores[17] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "My baby makes me feel anxious",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color19,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question19,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question19 = value;
                        color19 = Colors.grey;
                        scores[18] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I'm afraid of my baby",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color20,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question20,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question20 = value;
                        color20 = Colors.grey;
                        scores[19] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "My baby annoys me",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color21,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question21,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question21 = value;
                        color21 = Colors.grey;
                        scores[20] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I feel confident when caring for my baby",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color22,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question22,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question22 = value;
                        color22 = Colors.grey;
                        scores[21] = getScore(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I feel the only solution is for someone else to look after my baby",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color23,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question23,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question23 = value;
                        color23 = Colors.grey;
                        scores[22] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "I feel like hurting my baby",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color24,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question24,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question24 = value;
                        color24 = Colors.grey;
                        scores[23] = getScoreRev(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "My baby is easily Comforted",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: color25,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select One Option"),
                    items: questionList,
                    value: question25,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        question25 = value;
                        color25 = Colors.grey;
                        scores[24] = getScore(value);
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50, 0.0, 50, 0.0),
            child: MaterialButton(
              onPressed: submit,
              color: Colors.blue,
              child: Container(
              padding:EdgeInsets.all(12.0),
              child:Text("Submit",style: TextStyle(color:Colors.white),)
              ),
            )
          ),
        ],
      ),
    );
  }

  void submit() {
    if(question1 == null || question2 == null || question3 == null || question4 == null ||
        question5 == null || question6 == null || question7 == null || question8 == null ||
        question9 == null || question10 == null || question11 == null || question12 == null ||
        question13 == null || question14 == null || question15 == null || question16 == null ||
        question17 == null || question18 == null || question19 == null || question20 == null ||
        question21 == null || question22 == null || question23 == null || question24 == null ||
        question25 == null ){
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Some Field are emty")));
    }else{
      var data = Map<String,dynamic>();
      data["question1"] = question1;
      data["question2"] = question2;
      data["question3"] = question3;
      data["question4"] = question4;
      data["question5"] = question5;
      data["question6"] = question6;
      data["question7"] = question7;
      data["question8"] = question8;
      data["question9"] = question9;
      data["question10"] = question10;
      data["question11"] = question11;
      data["question12"] = question12;
      data["question13"] = question13;
      data["question14"] = question14;
      data["question15"] = question15;
      data["question16"] = question16;
      data["question17"] = question17;
      data["question18"] = question18;
      data["question19"] = question19;
      data["question20"] = question20;
      data["question21"] = question21;
      data["question22"] = question22;
      data["question23"] = question23;
      data["question24"] = question24;
      data["question25"] = question25;
      data["score"] = getfinalScore(scores);
      print(getfinalScore(scores));
      print(data);
      Firestore.instance.collection('user').document('$uniqueId').collection('pbq_responses').document('${response_count+1}').setData(data);
      Firestore.instance.collection('user').document('$uniqueId').updateData({"pbq_count":response_count+1});
      Navigator.pop(context);
    }
  }

  double getfinalScore(List<int> scores) {
    int sum=0;
    for(var i=0;i<scores.length;i++){
      sum+=scores[i];
    }
    return sum/scores.length;
  }

}