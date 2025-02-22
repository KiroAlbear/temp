// enum OfferDetailsEnum{
//
// }

import '../heroBanner/banner_response.dart';

class OfferMapper {
  late final String name;
  late final String image;
  late final int id;
  late final bool clickable;
  late final String link;
  late final int relatedItemId;

  OfferMapper(BannerResponse response) {
    name = response.title ?? '';
    image = response.imagePath ?? '';
    id = response.id ?? 0;
    clickable = (response.link ?? '').isNotEmpty;
    link = response.link ?? '';
    relatedItemId = response.relatedItemId ?? 0;
  }
}
