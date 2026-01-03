class UpdateAppResponseModel {
  String? versionNum;
  bool? isForce;
  int? type;

  UpdateAppResponseModel({this.versionNum, this.isForce, this.type});

  UpdateAppResponseModel.fromJson(Map<String, dynamic> json) {
    versionNum = json['versionNum'];
    isForce = json['isForce'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['versionNum'] = this.versionNum;
    data['isForce'] = this.isForce;
    data['type'] = this.type;
    return data;
  }
}
