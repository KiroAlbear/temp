import 'dart:ui';

import 'package:deel/core/dto/models/product/product_mapper.dart';


class ProductCartMapper extends ProductMapper{
  int requestedQuantity = 0;
  ProductCartMapper(ProductMapper productMapper) : super.fromProduct(null){
    requestedQuantity = minQuantity.toInt();

  }
  ProductCartMapper.fromProduct(super.productResponse) : super.fromProduct();

  void increase(){
    if(quantity > requestedQuantity && requestedQuantity> maxQuantity){
      requestedQuantity = requestedQuantity +1;
    }
  }

  void decrease(){
    if(requestedQuantity > minQuantity){
      requestedQuantity = requestedQuantity -1;
    }
  }

}