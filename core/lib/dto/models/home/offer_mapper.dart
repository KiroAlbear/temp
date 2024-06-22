// enum OfferDetailsEnum{
//
// }
import 'package:core/dto/models/heroBanner/banner_response.dart';

class OfferMapper {
  late final String name;
  late final String image;
  late final int id;
  late final bool clickable;
  late final int offerDetails;

  OfferMapper(BannerResponse response){
    name = response.title??'';
    image = response.imagePath??'';
    id = response.id??0;
    clickable = (response.link??'').isNotEmpty;
    offerDetails = response.relatedItemId??0;
  }
}
