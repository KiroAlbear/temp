class RecommendedItemsRequestModel {
  int? pageIndex;
  int? pageSize;
  int? companyTypeId;
  String? sortBy;
  String? sortDirection;
  String? token;

  RecommendedItemsRequestModel({
    this.pageIndex,
    this.pageSize,
    this.sortBy,
    this.sortDirection,
    this.token,
    this.companyTypeId,
  });

  RecommendedItemsRequestModel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    sortBy = json['sortBy'];
    sortDirection = json['sortDirection'];
    token = json['token'];
    companyTypeId = json['companyTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['sortBy'] = sortBy;
    data['token'] = token;
    data['sortDirection'] = sortDirection;
    data['companyTypeId'] = companyTypeId;
    return data;
  }
}
