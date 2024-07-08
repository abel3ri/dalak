import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

final emailRegex = RegExp(r"^[A-Za-z0-9.+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
final auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;
BaseOptions options = BaseOptions(
  connectTimeout: Duration(seconds: 10),
  receiveTimeout: Duration(seconds: 10),
);
final dio = Dio(options);
const BASE_URL = "https://app3.adamapress.com/wp-json/wp/v2";
