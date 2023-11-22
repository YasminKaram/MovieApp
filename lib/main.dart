import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Core/Utils/observers.dart';
import 'package:movieapp/MyApp.dart';
import 'package:movieapp/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer=MyBlocObserver();
  FirebaseFirestore.instance.disableNetwork();
  runApp(const MyApp());
}


