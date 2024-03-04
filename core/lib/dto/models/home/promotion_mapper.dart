class PromotionMapper{
  final String name;
  final String image;
  final int id;
  final bool clickable;
  final String description;

  PromotionMapper(
      {this.name = '', this.image = '', this.id = 0, this.clickable = false, this.description = ''});
}