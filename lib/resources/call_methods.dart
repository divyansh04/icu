import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icu/constants/strings.dart';
import 'package:icu/models/call.dart';

class CallMethods {

  final CollectionReference callCollection =
      Firestore.instance.collection(CALL_COLLECTION);
  Stream<DocumentSnapshot> callStream({String uid}) =>
      callCollection.document(uid).snapshots();

  Future<bool> makeCall({Call call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call.toMap(call);

      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);

      await callCollection.document(call.doctorId).setData(hasDialledMap);
      await callCollection.document(call.relativeId).setData(hasNotDialledMap);
      await callCollection.document(call.patientId).setData(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  Future<bool> makeRelativeCall({Call call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call.toMap(call);

      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);

      await callCollection.document(call.relativeId).setData(hasDialledMap);
      await callCollection.document(call.patientId).setData(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endPatientCall({Call call}) async {
    try {
      await callCollection.document(call.doctorId).delete();
      await callCollection.document(call.relativeId).delete();
      await callCollection.document(call.patientId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endRelativeIncomingCall({Call call}) async {
    try {
      await callCollection.document(call.relativeId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  Future<bool> endCall({Call call,user}) async {
    try {
      await callCollection.document(call.doctorId).updateData({'users':user});
      await callCollection.document(call.relativeId).updateData({'users':user});
      await callCollection.document(call.patientId).updateData({'users':user});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  Future<bool> joinCall({Call call,user}) async {
    try {
      await callCollection.document(call.doctorId).updateData({'users':user});
      await callCollection.document(call.relativeId).updateData({'users':user});
      await callCollection.document(call.patientId).updateData({'users':user});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  Future<bool> endRelativeInitiatedCall({Call call,user}) async {
    try {
      await callCollection.document(call.relativeId).updateData({'users':user});
      await callCollection.document(call.patientId).updateData({'users':user});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

}
