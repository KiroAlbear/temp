import 'package:core/dto/models/category/category_response.dart';

class CategoryMapper {
  String name = '';
  String image = '';
  int? id;
  bool clickable = false;
  bool isParent = true;
  int productExactCount = 0;

  CategoryMapper(CategoryResponse categoryResponse) {
    name = categoryResponse.name ?? '';
    image = categoryResponse.image ?? '';
    id = categoryResponse.id;
    productExactCount = categoryResponse.product_count_exact ?? 0;
    clickable = true;
    if (categoryResponse.parentId != null) {
      isParent = ((categoryResponse.parentId?.first as int?) ?? -1) == 1;
    }
  }
}
