import 'package:core/Utils/AppUtils.dart';
import 'package:core/core.dart';

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

  CategoryResponse({
    this.id,
    this.name,
    this.parentPath,
    this.image,
    this.parentId,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(Apputils.convertFlaseToNullJson(json));

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
