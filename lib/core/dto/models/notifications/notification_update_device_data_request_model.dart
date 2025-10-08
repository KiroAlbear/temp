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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['fcm'] = this.fcm;
    data['topics'] = this.topics;
    return data;
  }
}
