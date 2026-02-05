class NotificationsUpdateDeviceDataRequestModel {
  String? userId;
  String? fcm;
  List<int>? topics;

  NotificationsUpdateDeviceDataRequestModel({this.userId, this.fcm, this.topics});

  NotificationsUpdateDeviceDataRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fcm = json['fcm'];
    topics = json['topics'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['fcm'] = fcm;
    data['topics'] = topics;
    return data;
  }
}
