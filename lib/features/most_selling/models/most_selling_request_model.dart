class MostSellingRequestModel {
  int? pageIndex;
  int? pageSize;
  String? sortBy;
  String? sortDirection;
  String? token;

  MostSellingRequestModel({
    this.pageIndex,
    this.pageSize,
    this.sortBy,
    this.sortDirection,
    this.token,
  });

  MostSellingRequestModel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    sortBy = json['sortBy'];
    sortDirection = json['sortDirection'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['sortBy'] = sortBy;
    data['sortDirection'] = sortDirection;
    data['token'] = token;
    return data;
  }
}
