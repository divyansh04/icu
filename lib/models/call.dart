class Call {
  String doctorId;
  String doctorName;
  String patientId;
  String patientName;
  String relativeId;
  String relativeName;
  String channelId;
  bool hasDialled;
  int users;

  Call({
    this.doctorId,
    this.doctorName,
    this.patientId,
    this.patientName,
    this.relativeId,
  this.relativeName,
    this.channelId,
    this.hasDialled,
    this.users
  });

  // to map
  Map<String, dynamic> toMap(Call call) {
    Map<String, dynamic> callMap = Map();
    callMap["doctor_id"] = call.doctorId;
    callMap["doctor_name"] = call.doctorName;
    callMap["patient_id"] = call.patientId;
    callMap["patient_name"] = call.patientName;
    callMap["relative_id"] = call.relativeId;
    callMap["relative_name"] = call.relativeName;
    callMap["channel_id"] = call.channelId;
    callMap["has_dialled"] = call.hasDialled;
    callMap["users"] = call.users;
    return callMap;
  }

  Call.fromMap(Map callMap) {
    this.doctorId = callMap["doctor_id"];
    this.doctorName = callMap["doctor_name"];
    this.patientId = callMap["patient_id"];
    this.patientName = callMap["patient_name"];
    this.relativeId = callMap["relative_id"];
    this.relativeName = callMap["relative_name"];
    this.channelId = callMap["channel_id"];
    this.hasDialled = callMap["has_dialled"];
    this.users= callMap["users"];
  }
}
