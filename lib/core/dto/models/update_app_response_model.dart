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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['versionNum'] = versionNum;
    data['isForce'] = isForce;
    data['type'] = type;
    return data;
  }
}
