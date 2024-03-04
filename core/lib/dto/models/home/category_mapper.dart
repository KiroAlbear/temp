class CategoryMapper{
  final String name;
  final String image;
  final int id;
  final bool clickable;

  CategoryMapper(
      {this.name = '', this.image = '', this.id = 0, this.clickable = false});
}