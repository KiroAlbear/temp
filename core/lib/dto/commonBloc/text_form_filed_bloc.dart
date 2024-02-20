import 'package:core/ui/bases/bloc_base.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TextFormFiledBloc extends BlocBase {
  // A BehaviorSubject for managing the text form field controller.
  final textFormFiledBehaviour = BehaviorSubject<TextEditingController>();

  // A BehaviorSubject for managing a string value.
  final stringBehaviour = BehaviorSubject<String>();

  // Getter to access the current string value.
  String get value => stringBehaviour.valueOrNull ?? '';

  // Stream getter to access the text form field controller.
  Stream<TextEditingController> get textFormFiledStream =>
      textFormFiledBehaviour.stream;

  // Stream getter to access the string value.
  Stream<String> get stringStream => stringBehaviour.stream;

  // Method to update the string value.
  void updateStringBehaviour(String value) => stringBehaviour.sink.add(value);

  @override
  void dispose() {
    // Close the BehaviorSubjects when the bloc is disposed to release resources.
    textFormFiledBehaviour.close();
    stringBehaviour.close();
  }
}
