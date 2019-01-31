import 'package:flutter/material.dart';
import 'package:flutter_forms/firebase_services/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
class Home extends StatelessWidget{
  Home({this.userId, this.auth, this.onSignedOut});

  final String userId;
  final VoidCallback onSignedOut;
  final FireBaseAuth auth;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("logged In");
  }

}