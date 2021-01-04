class User {
  String uid;
  String name;
  String email;
  String username;
  String userRole;
  String relativeName;
  String relativeUid;
  String patientName;
  String patientUid;
  String fcmToken;

  User({
    this.patientName,
    this.patientUid,
    this.relativeName,
    this.relativeUid,
    this.uid,
    this.name,
    this.email,
    this.username,
    this.userRole,
    this.fcmToken
  });

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    data["userRole"] = user.userRole;
    data['relativeName'] = user.relativeName;
    data['relativeUid'] = user.relativeUid;
    data['patientName'] = user.patientName;
    data['patientUid'] = user.patientUid;
    data['fcmToken'] = user.fcmToken;
    return data;
  }

  // Named constructor
  User.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.userRole = mapData['userRole'];
    this.relativeName=mapData['relativeName'];
    this.relativeUid=mapData['relativeUid'];
    this.patientName=mapData['patientName'];
    this.patientUid=mapData['patientUid'];
    this.fcmToken=mapData['fcmToken'];
  }
}
