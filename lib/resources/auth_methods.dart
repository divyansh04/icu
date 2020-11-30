import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icu/constants/strings.dart';
import 'package:icu/enum/user_state.dart';
import 'package:icu/models/user.dart';
import 'package:icu/utils/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthMethods {
  static final Firestore _firestore = Firestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore firestore = Firestore.instance;

  static final CollectionReference _userCollection =
      _firestore.collection(USERS_COLLECTION);

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<User> getUserDetails() async {
    FirebaseUser currentUser = await getCurrentUser();

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

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication _signInAuthentication =
          await _signInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: _signInAuthentication.accessToken,
          idToken: _signInAuthentication.idToken);

      FirebaseUser user = await _auth.signInWithCredential(credential);
      Fluttertoast.showToast(msg: 'Signed in Successfully',textColor: Colors.black,backgroundColor: Colors.white);
      return user;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Signed in Failed',textColor: Colors.black,backgroundColor: Colors.white);
      print("Auth methods error");
      print(e);
      return null;
    }
  }
  Future<FirebaseUser> signUp(email,password)async{
    try{
      FirebaseUser user=await _auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
      Fluttertoast.showToast(msg: 'Signed Up Successfully',textColor: Colors.black,backgroundColor: Colors.white);
      return user;
    }catch(e){
      Fluttertoast.showToast(msg: 'Sign Up Failed',textColor: Colors.black,backgroundColor: Colors.white);
      print("Auth methods error");
      print(e.toString());
      return null;
    }
  }
  Future<FirebaseUser> signIn(email,password)async{
    try{
      FirebaseUser user=await _auth.signInWithEmailAndPassword(email: email.text, password: password.text);
      Fluttertoast.showToast(msg: 'Signed In Successfully',textColor: Colors.black,backgroundColor: Colors.white);
      return user;
    }catch(e){
      Fluttertoast.showToast(msg: 'Sign In Failed',textColor: Colors.black,backgroundColor: Colors.white);
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

  Future<void> addDataToDb(FirebaseUser currentUser) async {
    String username = Utils.getUsername(currentUser.email);

    User user = User(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        profilePhoto: currentUser.photoUrl,
        username: username);

    firestore
        .collection(USERS_COLLECTION)
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }
  Future<void> addDataToDataBase(FirebaseUser currentUser, name) async {
    String username = Utils.getUsername(currentUser.email);

    User user = User(
        uid: currentUser.uid,
        email: currentUser.email,
        name: name.toString(),
        profilePhoto: null,
        username: username);

    firestore
        .collection(USERS_COLLECTION)
        .document(currentUser.uid)
        .setData(user.toMap(user));
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

  Future<bool> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void setUserState({@required String userId, @required UserState userState}) {
    int stateNum = Utils.stateToNum(userState);

    _userCollection.document(userId).updateData({
      "state": stateNum,
    });
  }

  Stream<DocumentSnapshot> getUserStream({@required String uid}) =>
      _userCollection.document(uid).snapshots();
}
