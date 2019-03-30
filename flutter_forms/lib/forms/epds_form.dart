import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class EPDS extends StatelessWidget {
  final String uid;

  EPDS({this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "EPDS FORM",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: EPDSForm(uid: uid),
    );
  }
}

class EPDSForm extends StatefulWidget {
  final String uid;

  EPDSForm({this.uid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EPDSFormPage(uniqueId: uid);
  }
}

class EPDSFormPage extends State<EPDSForm> {
  final String uniqueId;

  EPDSFormPage({this.uniqueId});
  TextEditingController addressController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  DateTime babyDob;
  DateTime dob;
  String question1;
  List<DropdownMenuItem<String>> question1List = [];
  List<String> dropListques1 = [
    "As much as I always could",
    "Not quite so much now",
    "Definitely not so much",
    "Not at all"
  ];
  String question2;
  List<DropdownMenuItem<String>> question2List = [];
  List<String> dropListques2 = [
    "As much as I ever did",
    "Rather less than I used to",
    "Definitely less than I used to",
    "Hardly at all"
  ];
  String question3;
  List<DropdownMenuItem<String>> question3List = [];
  List<String> dropListques3 = [
    "Yes, most of the time",
    "Yes, some of the time",
    "Not very often",
    "No, never"
  ];
  String question4;
  List<DropdownMenuItem<String>> question4List = [];
  List<String> dropListques4 = [
    "No, not at all",
    "Hardly ever",
    "Yes, sometimes",
    "Yes, very often"
  ];
  String question5;
  List<DropdownMenuItem<String>> question5List = [];
  List<String> dropListques5 = [
    "Yes, quite a lot",
    "Yes, sometimes",
    "No, not much",
    "No,not at all"
  ];
  String question6;
  List<DropdownMenuItem<String>> question6List = [];
  List<String> dropListques6 = [
    "Yes, most of the time",
    "Yes, sometimes",
    "Most of the time I have coped quite well",
    "No, I have been coping as well as ever"
  ];
  String question7;
  List<DropdownMenuItem<String>> question7List = [];
  List<String> dropListques7 = [
    "Yes, most of times",
    "Yes, sometimes",
    "Not very often",
    "No, not at all"
  ];
  String question8;
  List<DropdownMenuItem<String>> question8List = [];
  List<String> dropListques8 = [
    "Yes, most of the time",
    "Yes, quite often",
    "Not very often",
    "No, not at all"
  ];
  String question9;
  List<DropdownMenuItem<String>> question9List = [];
  List<String> dropListques9 = [
    "Yes, most of the time",
    "Yes, quite often",
    "Only occassionally",
    "No, never"
  ];
  String question10;
  List<DropdownMenuItem<String>> question10List = [];
  List<String> dropListques10 = [
    "Yes, quite often",
    "Sometimes",
    "Hardly ever",
    "Never"
  ];
  List<int> scores = List(10);
  String name;
  DocumentReference documentReference;
  StreamSubscription<DocumentSnapshot> subscription;

  int response_count=0;
  bool autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int getScores(String value, List<String> list) {
    if (value == list[0]) {
      return 0;
    }
    if (value == list[1]) {
      return 1;
    }
    if (value == list[2]) {
      return 2;
    }
    if (value == list[3]) {
      return 3;
    }
  }

  int getScoresRev(String value, List<String> list) {
    if (value == list[0]) {
      return 3;
    }
    if (value == list[1]) {
      return 2;
    }
    if (value == list[2]) {
      return 1;
    }
    if (value == list[3]) {
      return 0;
    }
  }

  final formats = {
    InputType.date: DateFormat('yyyy-MM-dd'),
  };
  InputType inputType = InputType.date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    question1List = dropListques1
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    question2List = dropListques2
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    question3List = dropListques3
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    question4List = dropListques4
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    question5List = dropListques5
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    question6List = dropListques6
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    question7List = dropListques7
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    question8List = dropListques8
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    question9List = dropListques9
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    question10List = dropListques10
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    documentReference =
        Firestore.instance.collection('user').document('$uniqueId');
    subscription = documentReference.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          if (snapshot.data['name'].toString() != null) {
            name = snapshot.data['name'].toString();
          }
          if (snapshot.data['epds_count'].toString() != null) {
            response_count = snapshot.data['epds_count'];
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
      child: Form(
        key: _formKey,
        autovalidate: autoValidate,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black87, width: 0.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black87, width: 0.0),
                    ),
                    border: OutlineInputBorder(),
                    labelText: "Address",
                  ),
                  validator: (String value) {
                    if (value == "")
                      return "Please Enter your Addresss";
                    else
                      return null;
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: phoneController,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black87, width: 0.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black87, width: 0.0),
                    ),
                    border: OutlineInputBorder(),
                    labelText: "Phone",
                  ),
                  validator: (String value) {
                    if (value != "") {
                      if (value.length != 10)
                        return "Please Enter a Valid Mobile Number";
                      else
                        return null;
                    } else
                      return "Please Enter Mobile Number";
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: DateTimePickerFormField(
                    inputType: inputType,
                    format: formats[inputType],
                    decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        hasFloatingPlaceholder: false),
                    onChanged: (dt) => setState(() => dob = dt),
                    validator: (DateTime date) {
                      DateTime today = DateTime.now();
                      if(date!=null){
                        if (date.compareTo(today.subtract(Duration(days: 6750))) >
                            0) {
                          return "Please Enter a Valid Date";
                        } else
                          return null;
                      }else
                        return "Please Select a Date";
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: DateTimePickerFormField(
                    inputType: inputType,
                    format: formats[inputType],
                    decoration: InputDecoration(
                        labelText: "Baby's Date of Birth",
                        hasFloatingPlaceholder: false),
                    onChanged: (dt) => setState(() => babyDob = dt),
                    validator: (DateTime date) {
                      if (date != null) {
                        if (date.isAfter(DateTime.now()) ||
                            date.compareTo(DateTime.now()
                                    .subtract(Duration(days: 365))) <
                                0) {
                          return "Please Select a Valid Date";
                        } else
                          return null;
                      }else
                        return "Please Select a Date";
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  height: 1.0,
                  color: Colors.black38,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(12.0),
                  child: Text(
                    "As you are pregrent or have recently had a baby, we would like to know how are you feeling. Please select the option that comes closest to how you have felt in past 7 days, not just how you feel today.",
                    style: TextStyle(color: Colors.black87, fontSize: 16.0),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  height: 1.0,
                  color: Colors.black38,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "I have been able to laugh and see funny side of things",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(

                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: question1 == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select One Option"),
                          items: question1List,
                          value: question1,
                          iconSize: 30.0,
                          elevation: 8,

                          onChanged: (value) {
                            setState(() {
                              question1 = value;
                              scores[0] = getScores(value, dropListques1);
                            });
                          })),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "I have look forward with enjoyment to things",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: question2 == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select One Option"),
                          items: question2List,
                          value: question2,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              question2 = value;
                              scores[1] = getScores(value, dropListques2);
                            });
                          })),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "I have blamed myself unnecessaily when things went wrong",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: question3 == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select One Option"),
                          items: question3List,
                          value: question3,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              question3 = value;
                              scores[2] = getScoresRev(value, dropListques3);
                            });
                          })),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "I have been anxious or worried for no good reason",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(

                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: question4 == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select One Option"),
                          items: question4List,
                          value: question4,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              question4 = value;
                              scores[3] = getScores(value, dropListques4);
                            });
                          })),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "I have felt scared or panicky for no very good reason",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: question5 == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select One Option"),
                          items: question5List,
                          value: question5,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              question5 = value;
                              scores[4] = getScoresRev(value, dropListques5);
                            });
                          })),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "Things have been getting on top of me",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: question6 == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select One Option"),
                          items: question6List,
                          value: question6,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              question6 = value;
                              scores[5] = getScoresRev(value, dropListques6);
                            });
                          })),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "I have been so unhappy that I have had difficult sleeping",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: question7 == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select One Option"),
                          items: question7List,
                          value: question7,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              question7 = value;
                              scores[6] = getScoresRev(value, dropListques7);
                            });
                          })),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "I have felt sad or misserable",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: question8 == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select One Option"),
                          items: question8List,
                          value: question8,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              question8 = value;
                              scores[7] = getScoresRev(value, dropListques8);
                            });
                          })),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "I have been so unhappy that I have been crying",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: question9 == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select One Option"),
                          items: question9List,
                          value: question9,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              question9 = value;
                              scores[8] = getScoresRev(value, dropListques9);
                            });
                          })),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "The thought of harming myself has occured to me",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: question10 == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select One Option"),
                          items: question10List,
                          value: question10,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              question10 = value;
                              scores[9] = getScoresRev(value, dropListques10);
                            });
                          })),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    color: Colors.blue,
                  ),
                  margin: EdgeInsets.fromLTRB(50, 0.0, 50, 0.0),
                  child: GestureDetector(
                    onTap: submit,
                    child: Center(
                      child: Container(
                          padding:EdgeInsets.all(12.0),
                          child:Text("Submit",style: TextStyle(color:Colors.white),)
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            )),
      ),
    );
  }

  void submit() {
    if (!_formKey.currentState.validate()) {
      print("Not Validated");
      setState(() {
        autoValidate = true;
      });
    }else if(question1==""||question2==""||question3==""||question4==""||question5==""||question6==""||question7==""||question8==""||
        question9==""||question10==""){
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Some fields are Empty")));
    } else {
      int fScore= getFinalScore(scores);
      var data = Map<String, dynamic>();
      data["address"] = addressController.text.toString();
      data["phone"] = phoneController.text.toString();
      data["dob"] = dob;
      data["babyDob"] = babyDob;
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
      data["score"] = fScore;
      data["response_number"] = response_count + 1;
      Map recentEntry = Map<String,dynamic>();
      recentEntry['user id'] = uniqueId;
      recentEntry['name']= name;
      recentEntry['epds_response_number'] = response_count+1;
      recentEntry['form'] = "EPDS";
      recentEntry['score'] = fScore;
      recentEntry['date'] = DateTime.now();
      Firestore.instance
          .collection('user')
          .document('$uniqueId')
          .collection('epds_responses')
          .document('${response_count + 1}')
          .setData(data);
      Firestore.instance
          .collection('user')
          .document('$uniqueId')
          .updateData({"epds_count": response_count + 1});
      Firestore.instance.collection('recent_entries').document().setData(recentEntry);
      Navigator.pop(context,fScore);
    }
  }

  int getFinalScore(List<int> scores){
    int sum = 0;
    print(scores);
    for (var i = 0; i < scores.length; i++) {
      print(scores[i]);
      sum += scores[i];
    }
    return sum;
  }

}
