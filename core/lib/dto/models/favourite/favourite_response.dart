import 'package:core/core.dart';

part 'favourite_response.g.dart';

@JsonSerializable()
class FavouriteResponse {
  @JsonKey(name: 'id')
  int? id;

  FavouriteResponse();

  factory FavouriteResponse.fromJson(Map<String, dynamic> json) =>
      _$FavouriteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteResponseToJson(this);
}
