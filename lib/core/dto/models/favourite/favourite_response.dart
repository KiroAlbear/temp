import 'package:json_annotation/json_annotation.dart';

part 'favourite_response.g.dart';

@JsonSerializable()
class FavouriteResponse {
  FavouriteResponse();

  factory FavouriteResponse.fromJson(dynamic json) =>
      _$FavouriteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteResponseToJson(this);
}
