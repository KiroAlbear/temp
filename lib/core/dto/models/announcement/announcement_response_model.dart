class AnnouncementResponseModel {
  int? count;
  List<Announcements>? announcements;

  AnnouncementResponseModel({this.count, this.announcements});

  AnnouncementResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['announcements'] != null) {
      announcements = <Announcements>[];
      json['announcements'].forEach((v) {
        announcements!.add(new Announcements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.announcements != null) {
      data['announcements'] =
          this.announcements!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagePath'] = this.imagePath;
    data['link'] = this.link;
    data['orderNo'] = this.orderNo;
    data['relatedItemId'] = this.relatedItemId;
    return data;
  }
}
