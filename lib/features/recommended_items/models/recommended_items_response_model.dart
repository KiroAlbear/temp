import '../../../core/dto/models/product/product_response.dart';

class RecommendedItemsResponseModel {
  int? count;
  RecommendedItems? recommendedItems;

  RecommendedItemsResponseModel({this.count, this.recommendedItems});

  RecommendedItemsResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    recommendedItems = RecommendedItems.fromJson(json['recommendedItem']);
  }
}

class RecommendedItems {
  int? companyTypeId;
  String? companyTypeName;
  List<ProductResponse>? productResponse;

  RecommendedItems({
    this.companyTypeId,
    this.companyTypeName,
    this.productResponse,
  });

  RecommendedItems.fromJson(Map<String, dynamic> json) {
    companyTypeId = json['companyTypeId'];
    companyTypeName = json['companyTypeName'];
    if (json['productResponse'] != null) {
      productResponse = <ProductResponse>[];
      json['productResponse'].forEach((v) {
        productResponse!.add(new ProductResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyTypeId'] = this.companyTypeId;
    data['companyTypeName'] = this.companyTypeName;
    if (this.productResponse != null) {
      data['productResponse'] = this.productResponse!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}
