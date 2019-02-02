import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_forms/firebase_services/firebase_auth.dart';
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

  void _submit(String name, int pod, int age, int marraigeAge, int ageAtFirstP,
      int noOfP) async {
    var dataMap = new Map<String, dynamic>();
    dataMap['uid'] = Auth().getCurrentUser().toString();
    dataMap['Name'] = name;
    dataMap['Age'] = marraigeAge;
    dataMap["MarriageAge"] = marraigeAge;
    dataMap['Age at First Pre'] = ageAtFirstP;
    dataMap['No Of Preg'] = noOfP;
    db.collection("social_demo_forms").document().setData(dataMap);
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
  TextEditingController ageController = new TextEditingController();
  TextEditingController marraigeAgeController = new TextEditingController();
  TextEditingController ageAtFirstPController = new TextEditingController();
  TextEditingController noOfPController = new TextEditingController();

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
            controller: nameController,
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
              "Residential Locality: ",
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border.all(
                    color: Colors.grey,
                  )),
              child: Row(
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: null,
                    onChanged: null,
                  ),
                  new Text(
                    'Urban',
                    style: new TextStyle(fontSize: 14.0),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: null,
                    onChanged: null,
                  ),
                  new Text(
                    'Rural',
                    style: new TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  new Radio(
                    value: 2,
                    groupValue: null,
                    onChanged: null,
                  ),
                  new Text(
                    'Tribal',
                    style: new TextStyle(fontSize: 14.0),
                  ),
                ],
              )),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "Caste: ",
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
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: null,
                    onChanged: null,
                  ),
                  Center(
                    child: new Text(
                      'General',
                      style: new TextStyle(fontSize: 14.0),
                    ),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: null,
                    onChanged: null,
                  ),
                  Center(
                    child: new Text(
                      'SC(Schedule Caste)',
                      style: new TextStyle(fontSize: 14.0),
                    ),
                  ),
                  new Radio(
                    value: 2,
                    groupValue: null,
                    onChanged: null,
                  ),
                  Center(
                    child: new Text(
                      'ST(Schedule Tribe)',
                      style: new TextStyle(fontSize: 14.0),
                    ),
                  ),
                  new Radio(
                    value: 2,
                    groupValue: null,
                    onChanged: null,
                  ),
                  Center(
                    child: new Text(
                      'OBC',
                      style: new TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "Socio-Economic Status: ",
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
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: null,
                    onChanged: null,
                  ),
                  Center(
                    child: new Text(
                      'Antyoday (Poorest of Poor)',
                      style: new TextStyle(fontSize: 14.0),
                    ),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: null,
                    onChanged: null,
                  ),
                  Center(
                    child: new Text(
                      'BPL (Below Poverty Line)',
                      style: new TextStyle(fontSize: 14.0),
                    ),
                  ),
                  new Radio(
                    value: 2,
                    groupValue: null,
                    onChanged: null,
                  ),
                  Center(
                    child: new Text(
                      'APL (Above Poverty Line)',
                      style: new TextStyle(fontSize: 14.0),
                    ),
                  ),
                  new Radio(
                    value: 2,
                    groupValue: null,
                    onChanged: null,
                  ),
                  Center(
                    child: new Text(
                      'Don’t know',
                      style: new TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 16.0,
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
              labelText: "Number of families living together",
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
        noOfPController.text.toString() == "") {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Fill all the fields! Some Field are emty")));
    } else {
      _submit(
          nameController.text.toString(),
          int.tryParse(opdController.text),
          int.tryParse(ageController.text.toString()),
          int.tryParse(marraigeAgeController.text.toString()),
          int.tryParse(ageAtFirstPController.text.toString()),
          int.tryParse(noOfPController.text.toString()));
    }
  }
}
