import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/commonBloc/current_location_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/ui/bases/bloc_base.dart';

enum NewAccountStepEnum { info, locationInfo, editLocation, password }

class NewAccountBloc extends BlocBase {
  final TextFormFiledBloc fullNameBloc = TextFormFiledBloc();
  final TextFormFiledBloc facilityNameBloc = TextFormFiledBloc();
  final TextFormFiledBloc streetNameBloc = TextFormFiledBloc();
  final TextFormFiledBloc neighborhoodBloc = TextFormFiledBloc();
  final TextFormFiledBloc cityBloc = TextFormFiledBloc();
  final TextFormFiledBloc passwordBloc = TextFormFiledBloc();
  final TextFormFiledBloc confirmPasswordBloc = TextFormFiledBloc();
  final BehaviorSubject<NewAccountStepEnum> _stepBehaviour = BehaviorSubject()
    ..sink.add(NewAccountStepEnum.info);
  final ValidatorModule _validatorModule = ValidatorModule();
  final ButtonBloc buttonBloc = ButtonBloc();
  final BehaviorSubject<double?> _latitudeBehaviour = BehaviorSubject();
  final BehaviorSubject<double?> _longitudeBehaviour = BehaviorSubject();
  /// info recorded from preview steps

  set latitude(double value) => _latitudeBehaviour.sink.add(value);

  set longitude(double value) => _longitudeBehaviour.sink.add(value);

  double get latitude=> _latitudeBehaviour.value??0.0;

  double get longitude=> _latitudeBehaviour.value??0.0;

  Stream<double?> get latitudeStream=> _latitudeBehaviour.stream;

  Stream<double?> get longitudeStream=> _longitudeBehaviour.stream;

  Stream<bool> get validateInfoStream => Rx.combineLatest2(
      fullNameBloc.stringStream,
      facilityNameBloc.stringStream,
      (fullName, platformName) => isInfoValid);

  Stream<bool> get validateLocationStream => Rx.combineLatest3(
      streetNameBloc.stringStream,
      neighborhoodBloc.stringStream,
      cityBloc.stringStream,
      (street, neighborhood, cityBloc) => isLocationValid);

  Stream<bool> get validatePasswordStream => Rx.combineLatest(
      [passwordBloc.stringStream, confirmPasswordBloc.stringStream],
      (value) => isPasswordValid);

  Stream<NewAccountStepEnum> get stepsStream => _stepBehaviour.stream;

  void nextStep(NewAccountStepEnum stepEnum) {
    _stepBehaviour.sink.add(stepEnum);
  }

  bool get isInfoValid =>
      _validatorModule.isFiledNotEmpty(fullNameBloc.value) &&
      _validatorModule.isFiledNotEmpty(facilityNameBloc.value);

  bool get isLocationValid =>
      _validatorModule.isFiledNotEmpty(neighborhoodBloc.value) &&
      _validatorModule.isFiledNotEmpty(cityBloc.value) &&
      (latitude != 0.0) &&
      (longitude != 0.0);

  bool get isPasswordValid =>
      _validatorModule.isPasswordValid(passwordBloc.value) &&
      _validatorModule.isMatchValid(
          passwordBloc.value, confirmPasswordBloc.value);

  @override
  void dispose() {
    fullNameBloc.dispose();
    facilityNameBloc.dispose();
    _stepBehaviour.close();
    streetNameBloc.dispose();
    buttonBloc.dispose();
    neighborhoodBloc.dispose();
    cityBloc.dispose();
    passwordBloc.dispose();
    confirmPasswordBloc.dispose();
    _latitudeBehaviour.close();
    _longitudeBehaviour.close();
  }
}
