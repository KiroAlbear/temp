import 'package:deel/features/home/product/enums/product_notification_type.dart';

class NotificationResponseModel {
  String? name;
  String? id;
  String? type;
  NotificationType? notificationType;


  NotificationResponseModel({ this.name, this.id,this.type, this.notificationType });

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    type = json['type'];

    if (type == "1") {
      notificationType = NotificationType.brand;
    }else if (type == "2"){
      notificationType = NotificationType.category;
    }else if (type == "3"){
      notificationType = NotificationType.product;
    }else{
      notificationType = NotificationType.none;
    }

  }

}
