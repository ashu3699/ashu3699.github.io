class RegistrationData {
  String eventId;
  String uid;
  int registeredOn;
  String status;
  String confirmedBy;
  int confirmedOn;
  int maxTeamSize;
  String id;
  String registrationCode;

  RegistrationData({
    required this.eventId,
    required this.uid,
    required this.registeredOn,
    required this.status,
    required this.confirmedBy,
    required this.confirmedOn,
    required this.maxTeamSize,
    required this.id,
    required this.registrationCode,
  });

  factory RegistrationData.fromJson(Map<String, dynamic> json) =>
      RegistrationData(
        eventId: json["eventId"],
        uid: json["uid"],
        registeredOn: json["registeredOn"],
        status: json["status"],
        confirmedBy: json["confirmedBy"] ?? "",
        confirmedOn: json["confirmedOn"] ?? -1,
        maxTeamSize: json["maxTeamSize"] ?? "",
        id: json["_id"],
        registrationCode: json["registrationCode"],
      );
}

class EventRegistration {
  bool success;
  String message;
  RegistrationData registrationData;
  int amountToPay;

  EventRegistration({
    required this.success,
    required this.message,
    required this.registrationData,
    required this.amountToPay,
  });

  factory EventRegistration.fromJson(Map<String, dynamic> json) =>
      EventRegistration(
        success: json["success"],
        message: json["data"]["message"] ?? json["error"]["message"],
        registrationData:
            RegistrationData.fromJson(json["data"]["registration"]),
        amountToPay: json["data"]["amountToPay"],
      );
}
