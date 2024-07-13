import 'package:core/core.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:flutter/material.dart';
import 'package:update_profile/models/lat_lng.dart';

class UpdateProfileBloc extends BlocBase {
  BehaviorSubject<TextEditingController> nameBehavior = BehaviorSubject();
  BehaviorSubject<TextEditingController> phoneBehavior = BehaviorSubject();
  BehaviorSubject<TextEditingController> buildingNameBehavior =
      BehaviorSubject();
  BehaviorSubject<LatLng> locationBehavior = BehaviorSubject();
  BehaviorSubject<TextEditingController> buildingNumberBehavior =
      BehaviorSubject();
  BehaviorSubject<TextEditingController> districtBehavior = BehaviorSubject();
  BehaviorSubject<TextEditingController> governorateBehavior =
      BehaviorSubject();

  BehaviorSubject<String> nameStringBehavior = BehaviorSubject();
  BehaviorSubject<String> buildingNameStringBehavior = BehaviorSubject();

  // Stream<TextEditingController> get nameStream => nameBehavior.stream;

  void initializeNameBehaviour(String name) {
    nameBehavior.sink.add(TextEditingController(text: name));
  }

  void initializePhoneBehaviour(String phone) {
    phoneBehavior.sink.add(TextEditingController(text: phone));
  }

  void initializeBuildingNameBehaviour(String buildingName) {
    buildingNameBehavior.sink.add(TextEditingController(text: buildingName));
  }

  void initializeLocationBehaviour(LatLng location) {
    locationBehavior.sink.add(location);
  }

  void initializeBuildingNumberBehaviour(String buildingNumber) {
    buildingNumberBehavior.sink
        .add(TextEditingController(text: buildingNumber));
  }

  void initializeDistrictBehaviour(String district) {
    districtBehavior.sink.add(TextEditingController(text: district));
  }

  void initializeGovernorateBehaviour(String governorate) {
    governorateBehavior.sink.add(TextEditingController(text: governorate));
  }

  void updateName(String value) {
    nameStringBehavior.sink.add(value);
    print("********** name: $value");
  }

  void updateBuildingName(String value) {
    buildingNameStringBehavior.sink.add(value);
    print("********** buildingName: $value");
  }

  UpdateProfileBloc() {
    initializeNameBehaviour('هاجر أسامة عبد الغفار ');
    initializePhoneBehaviour('700000000');
    initializeBuildingNameBehaviour('Market Now');
    initializeLocationBehaviour(LatLng(latitude: 0, longitude: 0));
    initializeBuildingNumberBehaviour('5 شارع الحدادين ');
    initializeDistrictBehaviour('الحي');
    initializeGovernorateBehaviour('عدن');
  }

  @override
  void dispose() {
    nameBehavior.close();
  }
}
