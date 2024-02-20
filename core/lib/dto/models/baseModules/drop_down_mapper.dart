class DropDownMapper {
  late final String name;
  late final String id;
  late final String description;
  late bool selected;
  late final bool enable;
  late final String image;

  DropDownMapper(
      {required this.name,
      required this.id,
      this.description = '',
      this.selected = false,
      this.enable = true,
      this.image = ''});

  DropDownMapper.empty() {
    name = '';
    id = '';
    description = '';
    selected = false;
    enable = false;
    image = '';
  }
}
