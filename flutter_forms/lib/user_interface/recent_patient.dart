import 'package:flutter/material.dart';

class RecentP extends StatelessWidget {
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
      body: Patient(),
    );
  }
}

class Patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyPatient();
  }
}

class MyPatient extends State<Patient> {
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
                const ListTile(
                  leading: Icon(Icons.album),
                  title: Text('\n\nName: '),
                  subtitle: Text(
                      'No. of PBQ forms: \nNo. of EPDS forms: \nAction recommended: \n\n\n'),
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
