import '../../../../features/announcements/models/announcement_response_model.dart';
import '../heroBanner/banner_response.dart';

class OfferMapper {
  late final String name;
  late final String image;
  late final int id;
  late final bool clickable;
  late final String link;
  late final List<int> relatedItemId;

  OfferMapper({
    this.name = '',
    this.image = '',
    this.id = 0,
    this.clickable = false,
    this.link = '',
    this.relatedItemId = const [],
  });

  factory OfferMapper.fromBannerResponse(BannerResponse response) {
    return OfferMapper(
      name: response.title ?? '',
      image: response.imagePath ?? '',
      id: response.id ?? 0,
      clickable: (response.link ?? '').isNotEmpty,
      link: response.link ?? '',
      relatedItemId: response.relatedItemId ?? [],
    );
  }

  factory OfferMapper.fromAnnouncements(Announcements response) {
    return OfferMapper(
      name: '',
      image: response.imagePath ?? '',
      link: response.link!,
      relatedItemId:
          response.relatedItemId != null ? [response.relatedItemId!] : [],
    );
  }
}
