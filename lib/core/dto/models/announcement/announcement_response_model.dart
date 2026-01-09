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
  int? id;
  String? imagePath;
  String? link;
  bool? status;
  int? orderNo;
  String? createdAt;
  String? updatedAt;

  Announcements(
      {this.id,
      this.imagePath,
      this.link,
      this.status,
      this.orderNo,
      this.createdAt,
      this.updatedAt});

  Announcements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['imagePath'];
    link = json['link'];
    status = json['status'];
    orderNo = json['orderNo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imagePath'] = this.imagePath;
    data['link'] = this.link;
    data['status'] = this.status;
    data['orderNo'] = this.orderNo;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
