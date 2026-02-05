import '../../../core/dto/models/product/product_response.dart';

class MostSellingResponseModel {
  int? count;
  List<MostSeller>? mostSeller;

  MostSellingResponseModel({this.count, this.mostSeller});

  MostSellingResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['mostSeller'] != null) {
      mostSeller = <MostSeller>[];
      json['mostSeller'].forEach((v) {
        mostSeller!.add(MostSeller.fromJson(v));
      });
    }
  }
}

class MostSeller {
  int? relatedItemId;
  int? orderNo;
  List<ProductResponse>? productResponse;

  MostSeller({this.relatedItemId, this.orderNo, this.productResponse});

  MostSeller.fromJson(Map<String, dynamic> json) {
    relatedItemId = json['relatedItemId'];
    orderNo = json['orderNo'];
    if (json['productResponse'] != null) {
      productResponse = <ProductResponse>[];
      json['productResponse'].forEach((v) {
        productResponse!.add(ProductResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['relatedItemId'] = relatedItemId;
    data['orderNo'] = orderNo;
    if (productResponse != null) {
      data['productResponse'] = productResponse!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}
