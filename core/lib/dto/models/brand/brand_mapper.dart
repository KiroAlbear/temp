import 'package:core/dto/models/brand/brand_response.dart';

class BrandMapper {
  int id = -1;
  String name = "";
  String displayName = "";
  bool active = true;

  BrandMapper(BrandResponse brandResponse) {
    id = brandResponse.id ?? -1;
    name = brandResponse.name ?? '';
    displayName = brandResponse.display_name ?? '';
    active = brandResponse.active ?? false;
  }
}
