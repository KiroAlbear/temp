import 'package:core/dto/models/baseModules/drop_down_mapper.dart';
import 'package:flutter/material.dart';

class SettingsMapper {
  late final String id;
  late final String headerName;
  late final String childName;
  late final String imagePath;
  late final bool isForEdit;
  late List<DropDownMapper> dropDownList;
  late Widget? widget;


  SettingsMapper(
      {required this.id,
      required this.headerName,
      required this.childName,
      required this.imagePath,
      this.isForEdit = false,
      this.dropDownList = const [],
      this.widget});
}
