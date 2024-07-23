import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/remote/register_remote.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/login/login_mapper.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:core/dto/remote/update_address_remote.dart';

enum NewAccountStepEnum { info, locationInfo, editLocation, password }

class NewAccountBloc extends BlocBase {
  late final String _mobileNumber;
  late final int _countryId;

  void init({int countryId = 245, required String mobileNumber}) {
    _mobileNumber = mobileNumber;
    _countryId = countryId;
  }

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

  double get latitude => _latitudeBehaviour.value ?? 0.0;

  double get longitude => _latitudeBehaviour.value ?? 0.0;

  Stream<double?> get latitudeStream => _latitudeBehaviour.stream;

  Stream<double?> get longitudeStream => _longitudeBehaviour.stream;

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

  Stream<ApiState<LoginMapper>> get register => RegisterRemote(
          shopName: facilityNameBloc.value,
          name: fullNameBloc.value,
          phone: _mobileNumber,
          password: passwordBloc.value,
          latitude: _longitudeBehaviour.valueOrNull.toString(),
          longitude: _latitudeBehaviour.valueOrNull.toString())
      .callApiAsStream();

  Stream<
      ApiState<LoginMapper>> updateAddress(int clientId) => UpdateAddressRemote(
          clientId: clientId,
          street: streetNameBloc.value,
          street2: neighborhoodBloc.value,
          countryId: _countryId,
          city: cityBloc.value,
          latitude: _latitudeBehaviour.valueOrNull ?? 0.0,
          longitude: _longitudeBehaviour.valueOrNull ?? 0.0)
      .callApiAsStream();

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
