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
        productResponse!.add(ProductResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyTypeId'] = companyTypeId;
    data['companyTypeName'] = companyTypeName;
    if (productResponse != null) {
      data['productResponse'] = productResponse!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}
