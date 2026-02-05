class AnnouncementRequestModel {
  int? pageIndex;
  int? pageSize;
  String? sortBy;
  String? sortDirection;

  AnnouncementRequestModel(
      {this.pageIndex, this.pageSize, this.sortBy, this.sortDirection});

  AnnouncementRequestModel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    sortBy = json['sortBy'];
    sortDirection = json['sortDirection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['sortBy'] = sortBy;
    data['sortDirection'] = sortDirection;
    return data;
  }
}
