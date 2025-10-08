class NotificationsUpdateDeviceDataResponseModel {
  bool? isSuccess;
  String? message;


  NotificationsUpdateDeviceDataResponseModel({ this.isSuccess, this.message});

  NotificationsUpdateDeviceDataResponseModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    return data;
  }
}
