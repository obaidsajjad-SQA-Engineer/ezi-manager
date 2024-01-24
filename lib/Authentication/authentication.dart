// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Authentication extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String email;
  late String name;
  late String password;
  String? selectedRole;
  bool signInSuccess = false;

  Future<void> signUp() async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add additional user details to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'role': selectedRole,
      });

      // Save user information to SharedPreferences (if needed)
      // Navigate to the next screen (replace with your navigation logic)
    } catch (e) {
      // Handle signup errors
      print('Error during signup: $e');
    }
  }

  Future<void> signIn() async {
    try {
      // Sign in user with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Retrieve user details from Firestore based on UID
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      // Check if userDoc exists and has a role
      if (userDoc.exists && userDoc['role'] == selectedRole) {
        // Successfully logged in
        // You can add logic here to navigate to the appropriate screen based on the role
        print('Login successful!');
        signInSuccess = true;
      } else {
        // User does not have the selected role or userDoc does not exist
        print('Invalid credentials or role');
      }
    } catch (e) {
      // Handle login errors
      print('Error during login: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Add logic to navigate to the login screen after logout
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
