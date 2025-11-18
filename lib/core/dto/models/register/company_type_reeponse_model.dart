
class CompanyTypeResponseModel {
  int? id;
  String? name;
  String? type;
  bool? active;
  String? displayName;
  List<int>? createUid;
  String? createDate;
  List<int>? writeUid;
  String? writeDate;

  CompanyTypeResponseModel(
      {this.id,
        this.name,
        this.type,
        this.active,
        this.displayName,
        this.createUid,
        this.createDate,
        this.writeUid,
        this.writeDate});

  CompanyTypeResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    active = json['active'];
    displayName = json['display_name'];
    createUid = json['create_uid'].cast<int>();
    createDate = json['create_date'];
    writeUid = json['write_uid'].cast<int>();
    writeDate = json['write_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['active'] = this.active;
    data['display_name'] = this.displayName;
    data['create_uid'] = this.createUid;
    data['create_date'] = this.createDate;
    data['write_uid'] = this.writeUid;
    data['write_date'] = this.writeDate;
    return data;
  }
}
