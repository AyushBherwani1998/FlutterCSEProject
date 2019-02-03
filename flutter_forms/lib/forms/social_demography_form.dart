import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class SocialDemoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Social Demography Form",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyFormPage();
  }
}

class MyFormPage extends State<FormPage> {
  static Firestore db = Firestore.instance;

  void _submit({String name, int age, int marriageAge, int ageAtFirstP, int noOfP,int opd,int noOfFam,int noOfLiveBirth,int para}) async {
    var dataMap = new Map<String, dynamic>();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    dataMap['uid'] = user.uid;
    dataMap['Name'] = name;
    dataMap['OPD'] = opd;
    dataMap['Age'] = age;
    dataMap["MarriageAge"] = marriageAge;
    dataMap['Para'] = para;
    dataMap['Age At First Pregnancy'] = ageAtFirstP;
    dataMap['No Of Pregnancies'] = noOfP;
    dataMap['Annual Family Income'] = annualIncome;
    dataMap['No Of Families together'] = noOfFam;
    dataMap['No of Live Births'] = noOfLiveBirth;
    dataMap['Birth Interval'] = birthInterval;
    dataMap['Social-Economic Status'] = socialStatus;
    dataMap['Religion'] = religion;
    dataMap['Caste'] = caste;
    dataMap['Residential Locality'] = residentialLocality;
    dataMap["Date"]=date;
    final collRef = Firestore.instance.collection('social_demo_forms');
    final userRef = Firestore.instance.collection('user');
    DocumentReference docReference = collRef.document();

    docReference.setData(dataMap).then((doc) {
      print('hop ${docReference.documentID}');

      userRef.document("${user.uid}").updateData({"social_demo_form_id":docReference.documentID});
    }).catchError((error) {
      print(error);
    });

//    DocumentReference reference = await db.collection("social_demo_forms").add(dataMap);
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Submitted!")));
    Navigator.pop(context);
  }

  final formats = {
    InputType.date: DateFormat('yyyy-MM-dd'),
  };

  InputType inputType = InputType.date;
  DateTime date;

  TextEditingController nameController = new TextEditingController();
  TextEditingController opdController = new TextEditingController();
  TextEditingController noOfFamilies = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController marraigeAgeController = new TextEditingController();
  TextEditingController ageAtFirstPController = new TextEditingController();
  TextEditingController noOfPController = new TextEditingController();
  TextEditingController paraController = new TextEditingController();
  TextEditingController liveBirthController = TextEditingController();
  String residentialLocality;
  List<DropdownMenuItem<String>> residentialList = [];
  List<String> dropListRes = ["Urban","Rural","Tribal"];
  String caste;
  List<DropdownMenuItem<String>> casteList = [];
  List<String> dropListCaste = ["General","SC(Schedule Caste)","ST(Schedule Tribe)","OBC"];
  String religion;
  List<DropdownMenuItem<String>> religionList = [];
  List<String> dropListReligion = ["Hindu","Jain","Sikh","Buddhism","Parsi","Muslim","Christian","Other"];
  String socialStatus;
  List<DropdownMenuItem<String>> socialSList = [];
  List<String> dropListsocialStatus = ["Antyoday (Poorest of Poor)","BPL (Below Poverty Line)","APL (Above Poverty Line)","Don't Know"];
  String annualIncome;
  List<DropdownMenuItem<String>> annualIncomeList = [];
  List<String> dropListannualIncome = ["Less than Rs. 1.2 lakh","Rs. 1.2 lakh to Rs. 2.5 lakh","Rs. 2.5 lakh to Rs. 5 lakh","More than Rs. 5 lakh"];
  String birthInterval;
  List<DropdownMenuItem<String>> birthIntervalList = [];
  List<String> dropListBirthInterval = ["none","less than 12 months","12-24 months","more than 24 months"];


  @override
  void initState() {
    super.initState();
    residentialLocality = null;
    caste = null;
    religion = null;
    date=null;
    birthInterval = null;
    annualIncome = null;
    socialStatus = null;
    residentialList = dropListRes.map((val)=> new DropdownMenuItem(child: new Text(val),value: val,)).toList();
    casteList = dropListCaste.map((val)=> new DropdownMenuItem(child: new Text(val),value: val,)).toList();
    religionList = dropListReligion.map((val)=> new DropdownMenuItem(child: new Text(val),value: val,)).toList();
    socialSList = dropListsocialStatus.map((val)=> new DropdownMenuItem(child: new Text(val),value: val,)).toList();
    annualIncomeList = dropListannualIncome.map((val)=> new DropdownMenuItem(child: new Text(val),value: val,)).toList();
    birthIntervalList = dropListBirthInterval.map((val)=> new DropdownMenuItem(child: new Text(val),value: val,)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: 8.0,
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "Name",
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            keyboardType: TextInputType.numberWithOptions(),
            controller: opdController,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "OPD Number",
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
                  labelText: 'Date', hasFloatingPlaceholder: false),
              onChanged: (dt) => setState(() => date = dt),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "Residential Locality ",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border.all(
                    color: Colors.grey,
                  )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text("Select Residential Locality"),
                    items: residentialList,
                    value: residentialLocality,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        residentialLocality = value;
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
              "Caste",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
              height: 55.0,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border.all(
                    color: Colors.grey,
                  )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select Caste"),
                    items: casteList,
                    value: caste,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        caste = value;
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
              "Religion",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
              height: 55.0,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border.all(
                    color: Colors.grey,
                  )),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      hint: Text("Select Religion"),
                      items: religionList,
                      value: religion,
                      iconSize: 30.0,
                      elevation: 8,
                      onChanged: (value){
                        setState(() {
                          religion = value;
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
              "Social-Economic Status",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            height: 55.0,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: Colors.grey,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select Social-Econmic Status"),
                    items: socialSList,
                    value: socialStatus,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        socialStatus = value;
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            keyboardType: TextInputType.numberWithOptions(),
            controller: noOfFamilies,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "Number of families living together",
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "Annual Income",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            height: 55.0,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: Colors.grey,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select Annual Income"),
                    items: annualIncomeList,
                    value: annualIncome,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        annualIncome = value;
                      });
                    })
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            keyboardType: TextInputType.numberWithOptions(),
            controller: ageController,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "Age",
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            keyboardType: TextInputType.numberWithOptions(),
            controller: marraigeAgeController,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "Marriage Age",
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            keyboardType: TextInputType.numberWithOptions(),
            controller: ageAtFirstPController,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "Age at first pregnancy",
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            keyboardType: TextInputType.numberWithOptions(),
            controller: noOfPController,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "Gravida(No of Pregnancies)",
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            keyboardType: TextInputType.numberWithOptions(),
            controller: paraController,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "Para (No. of deliveries)",
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: liveBirthController,
              keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "No of live births",
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "Birth Interval",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  color: Colors.grey,
                )),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Select birth interval"),
                    items: birthIntervalList,
                    value: birthInterval,
                    iconSize: 30.0,
                    elevation: 8,
                    onChanged: (value){
                      setState(() {
                        birthInterval = value;
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
              ),
            ),
        ],
      ),
    );
  }

  void submit() {
    if (nameController.text.toString() == "" ||
        opdController.text.toString() == "" ||
        ageController.text.toString() == "" ||
        marraigeAgeController.text.toString() == "" ||
        ageAtFirstPController.text.toString() == "" ||
        noOfPController.text.toString() == "" ||
        paraController.text.toString() == "" ||
        noOfFamilies.text.toString() == "" ||
        liveBirthController.text.toString() == "" ||
        date == null || caste == null || religion == null ||
        socialStatus == null || annualIncome == null || birthInterval == null ||
        residentialLocality == null
    ) {
      String id = db.collection("social_demo_forms").document("user.uid_Response").documentID;
      print(id);
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Fill all the fields! Some Field are emty")));
    } else {
      _submit(
          name:nameController.text.toString(),
          age:int.tryParse(ageController.text.toString()),
          marriageAge:int.tryParse(marraigeAgeController.text.toString()),
          noOfFam: int.tryParse(noOfFamilies.text.toString()),
          noOfLiveBirth: int.tryParse(liveBirthController.text.toString()),
          ageAtFirstP: int.tryParse(ageAtFirstPController.text.toString()),
          opd: int.tryParse(opdController.text.toString()),
          noOfP: int.tryParse(noOfPController.text.toString()),
          para: int.tryParse(paraController.text.toString())

      );

    }
  }
}
