class Apputils {
  static Map<String, dynamic> convertFlaseToNullJson(
      Map<String, dynamic> json) {
    json.updateAll((key, value) => value == false ? null : value);

    return json;
  }
}
