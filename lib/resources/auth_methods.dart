import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icu/constants/strings.dart';
import 'package:icu/models/user.dart';
import 'package:icu/utils/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore firestore = Firestore.instance;
  Firestore _fireStore = Firestore.instance;
  static final CollectionReference _userCollection =
      firestore.collection(USERS_COLLECTION);

  FirebaseUser user;
  FirebaseUser currentUser;

  FirebaseUser getUser() {
    return this.user;
  }

  Future<FirebaseUser> getCurrentUser() async {
    this.currentUser = await _auth.currentUser();
    return this.currentUser;
  }

  Future<User> getUserDetails() async {
    this.currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
        await _userCollection.document(currentUser.uid).get();
    return User.fromMap(documentSnapshot.data);
  }

  Future<User> getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _userCollection.document(id).get();
      return User.fromMap(documentSnapshot.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<FirebaseUser> signUp(email, password) async {
    try {
      FirebaseUser user = await _auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      Fluttertoast.showToast(
          msg: 'Signed Up Successfully',
          textColor: Colors.black,
          backgroundColor: Colors.white);
      return user;
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Sign Up Failed',
          textColor: Colors.black,
          backgroundColor: Colors.white);
      print("Auth methods error");
      print(e.toString());
      return null;
    }
  }

  Future<FirebaseUser> signIn(email, password) async {
    try {
      FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Fluttertoast.showToast(
          msg: 'Signed In Successfully',
          textColor: Colors.black,
          backgroundColor: Colors.white);
      return user;
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Sign In Failed',
          textColor: Colors.black,
          backgroundColor: Colors.white);
      print("Auth methods error");
      print(e.toString());
      return null;
    }
  }

  Future<bool> authenticateUser(FirebaseUser user) async {
    QuerySnapshot result = await firestore
        .collection(USERS_COLLECTION)
        .where(EMAIL_FIELD, isEqualTo: user.email)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    //if user is registered then length of list > 0 or else less than 0
    return docs.length == 0 ? true : false;
  }

  Future<bool> isDoctor(String id) async {
    DocumentSnapshot currentUser =
        await _fireStore.collection('users').document(id).get();
    print(currentUser['userRole']);
    return currentUser['userRole'] == 'doctor' ? true : false;
  }

  Future<bool> isPatient(String id) async {
    DocumentSnapshot currentUser =
        await _fireStore.collection('users').document(id).get();
    print(currentUser['userRole']);
    return currentUser['userRole'] == 'patient' ? true : false;
  }

  Future<void> addDataToDb(FirebaseUser currentUser) async {
    String username = Utils.getUsername(currentUser.email);
    User user = User(
      uid: currentUser.uid,
      email: currentUser.email,
      name: currentUser.displayName,
      username: username,
      userRole: '',
    );

    firestore
        .collection(USERS_COLLECTION)
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }

  getCurrentUserDetails(String id) async {
    DocumentSnapshot currentUser =
        await _fireStore.collection('users').document(id).get();
    return currentUser;
  }

  Future<List<User>> fetchAllUsers(FirebaseUser currentUser) async {
    List<User> userList = List<User>();

    QuerySnapshot querySnapshot =
        await firestore.collection(USERS_COLLECTION).getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        userList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }
    return userList;
  }

  Future<List<User>> fetchPatients(FirebaseUser currentUser) async {
    List<User> userList = List<User>();

    QuerySnapshot querySnapshot = await firestore
        .collection(USERS_COLLECTION)
        .where('userRole', isEqualTo: 'patient')
        .getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        userList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }
    return userList;
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }


  Stream<DocumentSnapshot> getUserStream({@required String uid}) =>
      _userCollection.document(uid).snapshots();
}
