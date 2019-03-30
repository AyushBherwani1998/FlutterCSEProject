import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SocialDemoFormActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      body: SocialDemoFormBody(),
    );
  }
}

class SocialDemoFormBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SocialDemoFormBody();
  }
}

class _SocialDemoFormBody extends State<SocialDemoFormBody> {
  String uid = null;

  //Form Field Start
  bool checkExistingUser = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidateForm = false;

  //Variables for Purpose of visit
  List<DropdownMenuItem<String>> purposeOfVisitList = [];
  List<String> dropListPurposeOfVisit = [
    "O&G OPD",
    "Pediatrics OPD",
    "Psychiatry OPD",
    "Female Ward",
    "Pediatric Ward",
    "NICU",
    "PICU",
    "Other"
  ];
  List newDropListPurposeOfVisit;

  //Variables for Residential Locality
  String residentialLocality = null;
  List<DropdownMenuItem<String>> residentialLocalityList = [];
  List<String> dropListResidentialLocality = [
    "Urban",
    "Urban Slum",
    "Rural",
    "Tribal"
  ];

  //Variables for caste
  String caste = null;
  List<DropdownMenuItem<String>> casteList = [];
  List<String> dropListCaste = [
    "General",
    "Schedule Caste",
    "Schedule Tribe",
    "OBC"
  ];

  //Variables for Religion
  String religion = null;
  List<DropdownMenuItem<String>> religionList = [];
  List<String> dropListReligion = [
    "Hindu",
    "Jain",
    "Sikh",
    "Buddhism",
    "Parsi",
    "Muslim",
    "Christian",
    "Other"
  ];

  //Variables for Scoil Economic Status
  String socialEconomicStatus = null;
  List<DropdownMenuItem<String>> socialEconomicList = [];
  List<String> dropListSocialEconomicStatus = [
    "Antyoday",
    "Below Poverty Line",
    "Above Poverty Line",
    "Don't Know"
  ];

  //Variables for Marital Status
  String maritalStatus = null;
  List<DropdownMenuItem<String>> maritalList = [];
  List<String> dropListMaritalStatus = [
    "Married",
    "Single",
    "Live-in",
    "Divorced/Separated",
    "Widow"
  ];

  //Variables for Family Income
  String familyIncome = null;
  List<DropdownMenuItem<String>> familyIncomeList = [];
  List<String> dropListFamilyIncome = [
    "Less than Rs. 1.2 lakh ",
    "Rs. 1.2 lakh to Rs. 2.5 lakh",
    "Rs. 2.5 lakh to Rs. 5 lakh",
    "More than Rs. 5 lakh",
    "Don't want to disclose"
  ];

  //Variables of Birth Interval
  String birthInterval;
  List<DropdownMenuItem<String>> birthIntervalList = [];
  List<String> dropListBirthInterval = [
    "< 12 Months",
    "12-24 Months",
    ">24 months"
  ];

  //Variables for High Risk Pregnancy
  String highRiskPregnancy;
  List<DropdownMenuItem<String>> highRiskPregnancyList = [];
  List<String> dropListHighRiskPregnancy = ["Yes", "No"];

  //Variables for type of Delivery
  String typeOfDelivery;
  List<DropdownMenuItem<String>> typeOfDeliveryList = [];
  List<String> dropListTypeOfDelivery = ["Normal", "Vaccum", "C-Section"];

  //Variables for Place of Previous Delivery
  String placeOfPreviousDelivery;
  List<DropdownMenuItem<String>> placeOfPreviousDeliveryList = [];
  List<String> dropListPlaceOfPreviousDelivery = [
    "Primary Health Center",
    "Community Health Center",
    "District Hospital",
    "Private Maternity Home",
    "Private Hospital",
    "Home",
    "In Transit",
    "Other"
  ];

  //Variables for Sex of Previous Child
  String previousChildSex;
  List<DropdownMenuItem<String>> previousChildSexList = [];
  List<String> dropListPreviousChildSex = ["Male", "Female"];

  //TextEditor for forms Start
  //Case No
  TextEditingController caseNo = TextEditingController();

  //Name Of Research Assistant
  TextEditingController nameOfResearchAssistant = TextEditingController();

  //Consultant Name
  TextEditingController consultantName = TextEditingController();

  //Respondent Name
  TextEditingController respondentName = TextEditingController();

  //Mobile Number
  TextEditingController mobileNumber = TextEditingController();

  //City Name
  TextEditingController cityName = TextEditingController();

  //State Name
  TextEditingController stateName = TextEditingController();

  //Other Religion
  TextEditingController otherReligion = TextEditingController();

  //Number of Family Members
  TextEditingController numberOfFamilyMember = TextEditingController();

  //Age
  TextEditingController age = TextEditingController();

  //Age at Marriage
  TextEditingController ageAtMarriage = TextEditingController();

  //Current Gestational Age
  TextEditingController currentGestationalAge = TextEditingController();

  //Mothers Weight
  TextEditingController motherWeight = TextEditingController();

  //No of Pregnancies
  TextEditingController garvida = TextEditingController();

  //Age at first Pregnancy
  TextEditingController ageAtFirstP = TextEditingController();

  //Abortions
  TextEditingController abortions = TextEditingController();

  //Number of Deliveries
  TextEditingController para = TextEditingController();

  //Number of Live Births
  TextEditingController numberOfLiveBirths = TextEditingController();

  //Number Of Birth order
  TextEditingController birthOrderOfChild = TextEditingController();

  //TextEditor for Forms End

  //Date Field for Form Starts
  DateTime expectedDeliveryDate;
  final formats = {
    InputType.date: DateFormat('yyyy-MM-dd'),
  };
  InputType inputType = InputType.date;

  //Date field for Form Ends

  List<bool> validateForm = [];

  //Form Field Ends

  @override
  initState() {
    super.initState();
    newDropListPurposeOfVisit = [];
    purposeOfVisitList = dropListPurposeOfVisit
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    residentialLocalityList = dropListResidentialLocality
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    casteList = dropListCaste
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    religionList = dropListReligion
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    socialEconomicList = dropListSocialEconomicStatus
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    maritalList = dropListMaritalStatus
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    familyIncomeList = dropListFamilyIncome
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    birthIntervalList = dropListBirthInterval
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    highRiskPregnancyList = dropListHighRiskPregnancy
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    typeOfDeliveryList = dropListTypeOfDelivery
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    placeOfPreviousDeliveryList = dropListPlaceOfPreviousDelivery
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
    previousChildSexList = dropListPreviousChildSex
        .map((val) => new DropdownMenuItem(
              child: new Text(val),
              value: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),

      //ListView for the Form Fields
      child: Form(
        key: _formKey,
        autovalidate: _autoValidateForm,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                //Question 1
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "Purpose of Visit",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: newDropListPurposeOfVisit.isEmpty
                            ? Colors.red
                            : Colors.grey,
                      )),
                  child: Column(
                      children: dropListPurposeOfVisit
                          .map((String text) => Container(
                              child: CheckboxListTile(
                                  value:
                                      newDropListPurposeOfVisit.contains(text)
                                          ? true
                                          : false,
                                  title: Text(text),
                                  selected:
                                      newDropListPurposeOfVisit.contains(text)
                                          ? true
                                          : false,
                                  activeColor: Colors.blue,
                                  onChanged: (val) {
                                    print(val);
                                    setState(() {
                                      if (!newDropListPurposeOfVisit
                                          .contains(text)) {
                                        newDropListPurposeOfVisit.add(text);
                                        print(newDropListPurposeOfVisit);
                                      } else {
                                        newDropListPurposeOfVisit.remove(text);
                                        print(newDropListPurposeOfVisit);
                                      }
                                    });
                                  })))
                          .toList()),
                ),

                //Question 2
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: caseNo,
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
                    labelText: "Case Number",
                  ),
                  validator: (String value) {
                    if (value.length < 1)
                      return "Please Enter the Case Number";
                    else
                      return null;
                  },
                ),

                //Question 3
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: nameOfResearchAssistant,
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
                    labelText: "Research Assistant Name",
                  ),
                  validator: (String value) {
                    if (value.length < 1)
                      return "Please Enter Research Assistant Name";
                    else
                      return null;
                  },
                ),

                //Question 4
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: consultantName,
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
                    labelText: "Consultant Name",
                  ),
                  validator: (String value) {
                    if (value.length < 1)
                      return "Please Enter Consultant Name";
                    else
                      return null;
                  },
                ),

                //Question 5
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: respondentName,
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
                    labelText: "Respondent Name",
                  ),
                  validator: (String value) {
                    if (value.length < 1)
                      return "Please Enter Respoondent Name";
                    else
                      return null;
                  },
                ),

                //Question 6
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: mobileNumber,
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
                    labelText: "Mobile Number",
                    errorBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 0.0),
                    ),
                  ),
                  validator: (String mobileNumber) {
                    if (mobileNumber != "") {
                      if (mobileNumber.length != 10)
                        return "Please Enter a valid Mobile Number";
                      else
                        return null;
                    } else
                      return "Please Enter Mobile Number";
                  },
                ),

                //Question 7
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: cityName,
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
                    labelText: "City / Village / Town",
                  ),
                  validator: (String value) {
                    Firestore.instance
                        .collection('user')
                        .where('searchKeyName',
                        isEqualTo: mobileNumber.text.toString())
                        .getDocuments().then((QuerySnapshot docs){
                      if(docs.documents.length!=0){
                        setState(() {
                          checkExistingUser = true;

                        });
                      }
                    });

                    if (value.length < 1)
                      return "Please Enter your City";
                    else
                      return null;
                  },
                ),

                //Question 8
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "Residential Locality",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: residentialLocality == null
                            ? Colors.red
                            : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select Residential Locality"),
                          items: residentialLocalityList,
                          value: residentialLocality,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              residentialLocality = value;
                              validateForm.add(true);
                            });
                          })),
                ),

                //Question 9
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: stateName,
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
                    labelText: "State",
                  ),
                  validator: (String value) {
                    if (value.length < 1)
                      return "Please Enter your State";
                    else
                      return null;
                  },
                ),

                //Question 10
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "Caste",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: caste == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select Caste"),
                          items: casteList,
                          value: caste,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              caste = value;
                              validateForm.add(true);
                            });
                          })),
                ),

                //Question 11
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "Religion",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: religion == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select Religion"),
                          items: religionList,
                          value: religion,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              religion = value;
                              validateForm.add(true);
                            });
                          })),
                ),

                //Optional TextField
                religion == "Other"
                    ? Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              textCapitalization: TextCapitalization.words,
                              controller: otherReligion,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black87, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black87, width: 0.0),
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Other Religion",
                              ),
                              validator: (String value) {
                                if (value.length < 1)
                                  return "Please Enter Other Religion";
                                else
                                  return null;
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),

                //Question 12
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "Social Economic Status",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: socialEconomicStatus == null
                            ? Colors.red
                            : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select Social Economic Status"),
                          items: socialEconomicList,
                          value: socialEconomicStatus,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              socialEconomicStatus = value;
                              validateForm.add(true);
                            });
                          })),
                ),

                //Question 13
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  controller: numberOfFamilyMember,
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
                    labelText: "Number of Family Members",
                    errorBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 0.0),
                    ),
                  ),
                  validator: (String temp) {
                    if (temp != "") {
                      if (int.parse(temp) > 15) {
                        return "Please Enter a valid Number";
                      } else {
                        return null;
                      }
                    } else
                      return "Please Enter Number Of Family Members";
                  },
                ),

                //Question 14
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "Annual Family Income",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: familyIncome == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select Annual Family Income"),
                          items: familyIncomeList,
                          value: familyIncome,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              familyIncome = value;
                              validateForm.add(true);
                            });
                          })),
                ),

                //Question 15
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    controller: age,
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
                      labelText: "Enter your Age",
                      errorBorder: const OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 0.0),
                      ),
                    ),
                    validator: (String age) {
                      if (age != "") {
                        if (int.parse(age) < 18 || int.parse(age) > 45) {
                          return "Please Enter Valid Age";
                        } else
                          return null;
                      } else
                        return "Please Enter your Age";
                    }),

                //Question Marital Status(Added)
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "Marital Status",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: maritalStatus == null ? Colors.red : Colors.grey,
                      )),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select Marital Status"),
                          items: maritalList,
                          value: maritalStatus,
                          iconSize: 30.0,
                          elevation: 8,
                          onChanged: (value) {
                            setState(() {
                              maritalStatus = value;
                            });
                          })),
                ),

                //Question 16
                (maritalStatus != "Single" &&
                        maritalStatus != "Live-in" &&
                        maritalStatus != null)
                    ? Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: false),
                              controller: ageAtMarriage,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black87, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black87, width: 0.0),
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Age at Marriage",
                              ),
                              validator: (String age) {
                                if (age != "") {
                                  if (age.length < 2) {
                                    return "Enter a Valid Age";
                                  } else
                                    return null;
                                } else
                                  return "Enter Age at Marriage";
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
                //Clinical Label
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  color: Colors.black87,
                  height: 1.5,
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "Clinical History",
                    style: TextStyle(color: Colors.black54, fontSize: 14.0),
                  )),
                ),

                //Question 17
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
                        labelText: 'Expected Delivery Date',
                        hasFloatingPlaceholder: false),
                    onChanged: (dt) =>
                        setState(() => expectedDeliveryDate = dt),
                    validator: (DateTime date) {
                      if (date != null) {
                        if (!date.isAfter(DateTime.now())) {
                          return "Enter a valid Date";
                        } else
                          return null;
                      } else
                        return "Please Select a Date";
                    },
                  ),
                ),

                //Question 18
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    controller: currentGestationalAge,
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
                      labelText: "Current Gestational Age (In Weeks)",
                      errorBorder: const OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 0.0),
                      ),
                    ),
                    validator: (String gestationalAge) {
                      if (gestationalAge != "") {
                        if (int.parse(gestationalAge) < 10 ||
                            int.parse(gestationalAge) > 44) {
                          return "Please Enter Valid Number of Weeks";
                        } else
                          return null;
                      } else
                        return "Please Enter Gestational Age";
                    }),

                //Question 19
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: motherWeight,
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
                    labelText: "Mother's Weight",
                    errorBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 0.0),
                    ),
                  ),
                  validator: (String value) {
                    if (value != "")
                      return null;
                    else
                      return "Please Enter Mother's Weight";
                  },
                ),

                //Question 20
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: garvida,
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
                    labelText: "Total Pregnancies",
                    errorBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 0.0),
                    ),
                  ),
                  validator: (String number) {
                    if (number != "") {
                      if (number.length > 1 || int.parse(number) == 0) {
                        validateForm.add(true);
                        return "Please Enter a Valid Number";
                      } else
                        return null;
                    } else
                      return "Please Enter Total Pregnancies";
                  },
                ),

                //condition for next Questions
                garvida.text.toString() != ""
                    ? (int.parse(garvida.text.toString()) > 1)
                        ? Container(
                            child: Column(
                              children: <Widget>[
                                //Question 21
                                SizedBox(
                                  height: 16.0,
                                ),
                                TextFormField(
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  controller: ageAtFirstP,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black87, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black87, width: 0.0),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: "Age at First Pregnancy",
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 0.0),
                                    ),
                                  ),
                                  validator: (String number) {
                                    if (number != "") {
                                      if (int.parse(number) > 49 ||
                                          int.parse(number) < 14) {
                                        return "Please Enter a Valid Age";
                                      } else
                                        return null;
                                    } else
                                      return "Please Enter Age at First Pregnancy";
                                  },
                                ),

                                //Question 22
                                SizedBox(
                                  height: 16.0,
                                ),
                                TextFormField(
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  controller: abortions,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black87, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black87, width: 0.0),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: "Total Abortions",
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 0.0),
                                    ),
                                  ),
                                  validator: (String number) {
                                    if (number != "") {
                                      if (number.length > 1 ||
                                          int.parse(number) >
                                              int.parse(
                                                  garvida.text.toString())) {
                                        return "Please Enter a Valid Number";
                                      } else
                                        return null;
                                    } else
                                      return "Please Enter Total Abortions";
                                  },
                                ),

                                //Question 23
                                SizedBox(
                                  height: 16.0,
                                ),
                                TextFormField(
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  controller: para,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black87, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black87, width: 0.0),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: "Total Deliveries",
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 0.0),
                                    ),
                                  ),
                                  validator: (String number) {
                                    if (number != "") {
                                      if (number.length > 1 ||
                                          int.parse(number) >
                                              int.parse(
                                                  garvida.text.toString())) {
                                        return "Please Enter a Valid Number";
                                      } else
                                        return null;
                                    } else
                                      return "Please Enter Total Deliveries";
                                  },
                                ),

                                //Question 24
                                SizedBox(
                                  height: 16.0,
                                ),
                                TextFormField(
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  controller: numberOfLiveBirths,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black87, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black87, width: 0.0),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: "Number of Live Births",
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 0.0),
                                    ),
                                  ),
                                  validator: (String number) {
                                    if (number != "") {
                                      if (number.length > 1 ||
                                          int.parse(number) >
                                              int.parse(para.text.toString())) {
                                        validateForm.add(true);
                                        return "Please Enter a Valid Number";
                                      } else
                                        validateForm.add(false);
                                    } else
                                      return "Please Enter a Number";
                                  },
                                ),

                                //Question 25
                                SizedBox(
                                  height: 16.0,
                                ),
                                TextFormField(
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  controller: birthOrderOfChild,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black87, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black87, width: 0.0),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText:
                                        "Birth Order for Current Pregnancy",
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 0.0),
                                    ),
                                  ),
                                  validator: (String number) {
                                    if (number != "") {
                                      if (number.length > 1 ||
                                          int.parse(number) !=
                                              int.parse(numberOfLiveBirths.text
                                                      .toString()) +
                                                  1) {
                                        validateForm.add(true);
                                        return "Please Enter a Valid Order";
                                      } else
                                        validateForm.add(false);
                                    } else
                                      return "Please Enter Birth Order";
                                  },
                                ),

                                //Question 27
                                SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Birth Interval",
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 14.0),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      border: Border.all(
                                        color: birthInterval == null
                                            ? Colors.red
                                            : Colors.grey,
                                      )),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          hint: Text("Select Birth Interval"),
                                          items: birthIntervalList,
                                          value: birthInterval,
                                          iconSize: 30.0,
                                          elevation: 8,
                                          onChanged: (value) {
                                            setState(() {
                                              birthInterval = value;
                                              validateForm.add(true);
                                            });
                                          })),
                                ),

                                //Question 28
                                SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Is this High Risk Pregnancy?",
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 14.0),
                                  ),
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      border: Border.all(
                                        color: highRiskPregnancy == null
                                            ? Colors.red
                                            : Colors.grey,
                                      )),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          hint: Text("Select Birth Interval"),
                                          items: highRiskPregnancyList,
                                          value: highRiskPregnancy,
                                          iconSize: 30.0,
                                          elevation: 8,
                                          onChanged: (value) {
                                            setState(() {
                                              highRiskPregnancy = value;
                                              validateForm.add(true);
                                            });
                                          })),
                                ),

                                //Previous Pregnancy History Section Label
                                SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  color: Colors.black87,
                                  height: 1.5,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                    "History about Prvious Pregnancy",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0),
                                  )),
                                ),

                                //Question 29
                                SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Type of Delivery",
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 14.0),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      border: Border.all(
                                        color: typeOfDelivery == null
                                            ? Colors.red
                                            : Colors.grey,
                                      )),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                    hint: Text("Select One Option"),
                                    items: typeOfDeliveryList,
                                    value: typeOfDelivery,
                                    iconSize: 30.0,
                                    elevation: 8,
                                    onChanged: (value) {
                                      setState(() {
                                        typeOfDelivery = value;
                                        validateForm.add(true);
                                      });
                                    },
                                  )),
                                ),

                                //Question 30
                                SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Place of Previous Delivery",
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 14.0),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      border: Border.all(
                                        color: placeOfPreviousDelivery == null
                                            ? Colors.red
                                            : Colors.grey,
                                      )),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          hint: Text("Select One Option"),
                                          items: placeOfPreviousDeliveryList,
                                          value: placeOfPreviousDelivery,
                                          iconSize: 30.0,
                                          elevation: 8,
                                          onChanged: (value) {
                                            setState(() {
                                              placeOfPreviousDelivery = value;
                                              validateForm.add(true);
                                            });
                                          })),
                                ),

                                //Question 32
                                SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Previous Child Sex",
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 14.0),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      border: Border.all(
                                        color: previousChildSex == null
                                            ? Colors.red
                                            : Colors.grey,
                                      )),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          hint: Text("Select Gender"),
                                          items: previousChildSexList,
                                          value: previousChildSex,
                                          iconSize: 30.0,
                                          elevation: 8,
                                          onChanged: (value) {
                                            setState(() {
                                              previousChildSex = value;
                                            });
                                          })),
                                ),
                              ],
                            ),
                          )
                        : Container()
                    : Container(),
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
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                )
              ],
            )),
      ),
    );
  }

  void submit() {
    if (_formKey.currentState.validate()) {
      print("validated");
      if (int.parse(garvida.text.toString()) > 1) {
        if (newDropListPurposeOfVisit.isEmpty ||
            caste.isEmpty ||
            religion.isEmpty ||
            residentialLocality.isEmpty ||
            socialEconomicStatus.isEmpty ||
            birthInterval.isEmpty ||
            familyIncome.isEmpty ||
            highRiskPregnancy.isEmpty ||
            placeOfPreviousDelivery.isEmpty ||
            previousChildSex.isEmpty ||
            placeOfPreviousDelivery.isEmpty) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Some fields are Empty")));
        }else if(checkExistingUser){
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("User Already Exists")));
        } else {
          Map map = Map<String, dynamic>();
          map['date'] = DateTime.now();
          map['purpose for hospital visit'] = newDropListPurposeOfVisit;
          map['case no'] = caseNo.text.toString();
          map['research assistant name'] =
              nameOfResearchAssistant.text.toString();
          map['consultant name'] = consultantName.text.toString();
          map['respondent name'] = respondentName.text.toString();
          map['mobile'] = mobileNumber.text.toString();
          map['city'] = cityName.text.toString();
          map['residential locality'] = residentialLocality;
          map['state'] = stateName.text.toString();
          map['caste'] = caste;
          (religion == "Other")
              ? map['religion'] = otherReligion
              : map['religion'] = religion;
          map['social-econmic status'] = socialEconomicStatus;
          map['no of family members'] = numberOfFamilyMember.text.toString();
          map['annual income'] = familyIncome;
          map['age'] = age.text.toString();
          map['marital status'] = maritalStatus;
          if(maritalStatus!="Single" && maritalStatus !="Live-in"){
            map['age at marriage'] = ageAtMarriage.text.toString();
          }
          map['expected delivery date'] = expectedDeliveryDate;
          map['gestational age'] = currentGestationalAge.text.toString();
          map['weight'] = motherWeight.text.toString();
          map['garvida'] = garvida.text.toString();
          map['age at first pregnancy'] = ageAtFirstP.text.toString();
          map['abortions'] = abortions.text.toString();
          map['para'] = para.text.toString();
          map['no of live births'] = numberOfLiveBirths.text.toString();
          map['current birth order'] = birthOrderOfChild.text.toString();
          map['birth interval'] = birthInterval;
          map['high risk pregnancy'] = highRiskPregnancy;
          map['type of delivery'] = typeOfDelivery;
          map['place of previous delivery'] = placeOfPreviousDelivery;
          map['previous child sex'] = previousChildSex;
          Map userData = Map<String, dynamic>();
          userData['name'] = respondentName.text.toString();
          userData['searchKeyName'] = respondentName.text.toString().substring(0,1);
          userData['searchKey'] = mobileNumber.text.toString().substring(0, 1);
          userData['age'] = age.text.toString();
          userData['mobile'] = mobileNumber.text.toString();
          userData['epds_count'] = 0;
          userData['pbq_count'] = 0;
          final collRef = Firestore.instance.collection('user');
          DocumentReference docReference = collRef.document();
          docReference
              .collection('social demography form')
              .document('response')
              .setData(map)
              .then((doc) {
            print(docReference.documentID);
            uid = docReference.documentID;
          });
          Firestore.instance
              .collection('user')
              .document(uid)
              .setData(userData)
              .whenComplete(() {
            Navigator.pop(context, uid);
          });
        }
      } else {
        if (newDropListPurposeOfVisit.isEmpty ||
            caste.isEmpty ||
            religion.isEmpty ||
            residentialLocality.isEmpty ||
            socialEconomicStatus.isEmpty ||
            familyIncome.isEmpty) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Some fields are Empty")));
        }else if(checkExistingUser){
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("User Already Exists")));
        }else {
          Map map = Map<String, dynamic>();
          map['date'] = DateTime.now();
          map['purpose for hospital visit'] = newDropListPurposeOfVisit;
          map['case no'] = caseNo.text.toString();
          map['research assistant name'] =
              nameOfResearchAssistant.text.toString();
          map['consultant name'] = consultantName.text.toString();
          map['respondent name'] = respondentName.text.toString();
          map['mobile'] = mobileNumber.text.toString();
          map['city'] = cityName.text.toString();
          map['residential locality'] = residentialLocality;
          map['state'] = stateName.text.toString();
          map['caste'] = caste;
          (religion == "Other")
              ? map['religion'] = otherReligion
              : map['religion'] = religion;
          map['social-econmic status'] = socialEconomicStatus;
          map['no of family members'] = numberOfFamilyMember.text.toString();
          map['annual income'] = familyIncome;
          map['age'] = age.text.toString();
          if(maritalStatus!="Single" && maritalStatus !="Live-in"){
            map['age at marriage'] = ageAtMarriage.text.toString();
          }
          map['age at marriage'] = ageAtMarriage.text.toString();
          map['expected delivery date'] = expectedDeliveryDate;
          map['gestational age'] = currentGestationalAge.text.toString();
          map['weight'] = motherWeight.text.toString();
          map['garvida'] = garvida.text.toString();
          Map userData = Map<String, dynamic>();
          userData['name'] = respondentName.text.toString();
          userData['searchKey'] = mobileNumber.text.toString().substring(0, 1);
          userData['searchKeyName'] = respondentName.text.toString().substring(0,1);
          userData['age'] = age.text.toString();
          userData['mobile'] = mobileNumber.text.toString();
          userData['epds_count'] = 0;
          userData['pbq_count'] = 0;
          final collRef = Firestore.instance.collection('user');
          DocumentReference docReference = collRef.document();
          docReference
              .collection('social demography form')
              .document('response')
              .setData(map)
              .then((doc) {
            print(docReference.documentID);
            uid = docReference.documentID;
          });
          Firestore.instance
              .collection('user')
              .document(uid)
              .setData(userData)
              .whenComplete(() {
            Navigator.pop(context, uid);
          });
        }
      }
    } else
      print("not validated");
  }
}
