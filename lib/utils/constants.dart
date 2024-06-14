import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final emailRegex = RegExp(r"^[A-Za-z0-9.+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
final auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;
