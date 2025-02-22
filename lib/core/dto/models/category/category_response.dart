import 'package:json_annotation/json_annotation.dart';

import '../../../Utils/AppUtils.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'parent_path')
  String? parentPath;

  @JsonKey(name: 'image_1920')
  String? image;

  @JsonKey(name: 'parent_id')
  List<Object>? parentId;

  @JsonKey(name: 'product_count')
  int? product_count;

  @JsonKey(name: 'product_count_exact')
  int? product_count_exact;

  CategoryResponse({
    this.id,
    this.name,
    this.parentPath,
    this.image,
    this.parentId,
    this.product_count,
    this.product_count_exact,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(Apputils.convertFlaseToNullJson(json));

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
