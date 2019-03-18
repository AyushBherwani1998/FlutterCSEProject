import 'package:flutter/material.dart';
import './login/firebase_auth_login.dart';
import 'package:flutter_forms/firebase_services/firebase_auth.dart';

void main() => runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  title: "Forms",
  home: FireBaseAuthClass(auth: new Auth(),),
));