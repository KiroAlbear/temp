class AnnouncementResponseModel {
  int? count;
  List<Announcements>? announcements;

  AnnouncementResponseModel({this.count, this.announcements});

  AnnouncementResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['announcements'] != null) {
      announcements = <Announcements>[];
      json['announcements'].forEach((v) {
        announcements!.add(Announcements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (announcements != null) {
      data['announcements'] =
          announcements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Announcements {
  String? imagePath;
  String? link;
  int? orderNo;
  int? relatedItemId;

  Announcements({this.imagePath, this.link, this.orderNo, this.relatedItemId});

  Announcements.fromJson(Map<String, dynamic> json) {
    imagePath = json['imagePath'];
    link = json['link'];
    orderNo = json['orderNo'];
    relatedItemId = json['relatedItemId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imagePath'] = imagePath;
    data['link'] = link;
    data['orderNo'] = orderNo;
    data['relatedItemId'] = relatedItemId;
    return data;
  }
}
