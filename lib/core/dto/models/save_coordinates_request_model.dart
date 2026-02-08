class SaveCoordinatesRequestModel {
  int clientId;
  String latitude;
  String longitude;
  SaveCoordinatesRequestModel({
    required this.clientId,
  required this.latitude,
  required this.longitude
  });

  Map<String, dynamic> toJson() => {
    'UserId': clientId,
    'XAxis': latitude,
    'YAxis': longitude
  };
}