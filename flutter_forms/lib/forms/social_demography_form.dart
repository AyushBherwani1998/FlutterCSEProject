import 'package:flutter/material.dart';
class SocialDemoForm extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Social Demography Form",style: TextStyle(color: Colors.black),),
        centerTitle:true,
        backgroundColor: Colors.white,
      ),
      body: FormPage(),
    );
  }

}

class FormPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyFormPage();
  }

}

class MyFormPage extends State<FormPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(height: 8.0,),
          TextField(
            controller: null,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "Name",
              labelStyle:
              TextStyle(color: Colors.black, fontFamily: 'Oswald'),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: null,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "OPD",
              labelStyle:
              TextStyle(color: Colors.black, fontFamily: 'Oswald'),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              border: Border.all(
                color: Colors.grey,
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0,10.0,8.0,8.0) ,
                  child:  Text("Residential Locality",textAlign: TextAlign.left,),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Row(
                  children: <Widget>[
                    new Radio(
                      value: 0,
                      groupValue: null,
                      onChanged: null,
                    ),
                    new Text(
                      'Urban',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    new Radio(
                      value: 1,
                      groupValue: null,
                      onChanged: null,
                    ),
                    new Text(
                      'Rural',
                      style: new TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    new Radio(
                      value: 2,
                      groupValue: null,
                      onChanged: null,
                    ),
                    new Text(
                      'Tribal',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
         SizedBox(
           height: 90.0,
           width: MediaQuery.of(context).size.width,
           child: Container(
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(4.0)),
                 border: Border.all(
                   color: Colors.grey,
                 )
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Padding(
                   padding: EdgeInsets.fromLTRB(8.0,10.0,8.0,8.0) ,
                   child:  Text("Caste",textAlign: TextAlign.left,),
                 ),
                 SizedBox(
                   height: 3.0,
                 ),
                 Row(
                   children: <Widget>[
                     new Radio(
                       value: 0,
                       groupValue: null,
                       onChanged: null,
                     ),
                     new Text(
                       'General',
                       style: new TextStyle(fontSize: 16.0),
                     ),
                     new Radio(
                       value: 1,
                       groupValue: null,
                       onChanged: null,
                     ),
                     new Text(
                       'ST',
                       style: new TextStyle(
                         fontSize: 16.0,
                       ),
                     ),
                     new Radio(
                       value: 2,
                       groupValue: null,
                       onChanged: null,
                     ),
                     new Text(
                       'SC',
                       style: new TextStyle(fontSize: 16.0),
                     ),
                     new Radio(
                       value: 2,
                       groupValue: null,
                       onChanged: null,
                     ),
                     new Text(
                       'OBC',
                       style: new TextStyle(fontSize: 16.0),
                     ),
                   ],
                 )
               ],
             ),
           ),
         ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: null,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "Age",
              labelStyle:
              TextStyle(color: Colors.black, fontFamily: 'Oswald'),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: null,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "Age at Marriage",
              labelStyle:
              TextStyle(color: Colors.black, fontFamily: 'Oswald'),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: null,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "Age at first Pregnancy (in completed years) ",
              labelStyle:
              TextStyle(color: Colors.black, fontFamily: 'Oswald'),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: null,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "Garvida(No of Pregnancies) ",
              labelStyle:
              TextStyle(color: Colors.black, fontFamily: 'Oswald'),
            ),
          ),
        ],
      ),
    );
  }
}