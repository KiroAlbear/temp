class RecommendedItemsRequestModel {
  int? pageIndex;
  int? pageSize;
  int? companyTypeId;
  String? sortBy;
  String? sortDirection;

  RecommendedItemsRequestModel({
    this.pageIndex,
    this.pageSize,
    this.sortBy,
    this.sortDirection,
    this.companyTypeId,
  });

  RecommendedItemsRequestModel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    sortBy = json['sortBy'];
    sortDirection = json['sortDirection'];
    companyTypeId = json['companyTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['sortBy'] = this.sortBy;
    data['sortDirection'] = this.sortDirection;
    data['companyTypeId'] = this.companyTypeId;
    return data;
  }
}
