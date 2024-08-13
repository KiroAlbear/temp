import 'package:core/dto/models/category/category_response.dart';

class CategoryMapper{
  String name = '';
  String image= '';
  int id= -1;
  bool clickable = false;

  bool isParent = true;

  CategoryMapper(CategoryResponse categoryResponse){
    name = categoryResponse.name??'';
    image = categoryResponse.image??'';
    id = categoryResponse.id?? -1;
    clickable = true;
    if(categoryResponse.parentId != null){
      isParent = ((categoryResponse.parentId?.first as int?)?? -1) == 1;
    }
  }
}