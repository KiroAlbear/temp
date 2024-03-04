class OfferMapper {
  final String name;
  final String image;
  final int id;
  final bool clickable;
  final String offerDetails;

  OfferMapper(
      {this.name = '', this.image = '', this.id = 0, this.clickable = false, this.offerDetails = ''});
}
