import 'dart:convert';

import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

enum NewAccountStepEnum { info, locationInfo, password }

class NewAccountBloc extends BlocBase {
  String mobileNumber = "";
  int _countryId = 0;
  String countryCode = "";

  void init({
    int countryId = 245,
    required String mobileNumberValue,
    required String countryCode,
  }) {
    mobileNumber = mobileNumberValue;
    _countryId = countryId;
    this.countryCode = "+$countryCode";

    fullNameBloc.textFormFiledBehaviour.sink.add(TextEditingController());
    fullNameBloc.stringBehaviour.add("");

    facilityNameBloc.textFormFiledBehaviour.sink.add(TextEditingController());
    facilityNameBloc.stringBehaviour.add("");

    streetNameBloc.textFormFiledBehaviour.sink.add(TextEditingController());
    streetNameBloc.stringBehaviour.add("");


    cityBloc.textFormFiledBehaviour.sink.add(TextEditingController());
    cityBloc.stringBehaviour.add("");

    districtBloc.textFormFiledBehaviour.sink.add(TextEditingController());
    districtBloc.stringBehaviour.add("");

    companyBloc.textFormFiledBehaviour.sink.add(TextEditingController());
    companyBloc.stringBehaviour.add("");

    selectedCompany = null;

    passwordBloc.textFormFiledBehaviour.sink.add(TextEditingController());
    passwordBloc.stringBehaviour.add("");

    confirmPasswordBloc.textFormFiledBehaviour.sink.add(
      TextEditingController(),
    );
    confirmPasswordBloc.stringBehaviour.add("");

    _stepBehaviour.sink.add(NewAccountStepEnum.info);
    countryCodeBehaviour.sink.add("+$countryCode");

    _latitudeBehaviour.sink.add(null);
    _longitudeBehaviour.sink.add(null);

    StateRemote(countryId).callApiAsStream().listen((event) {
      _stateBehaviour.sink.add(event);
    });

    CompanyTypeRemote().callApiAsStream().listen((event) {
      _companyTypeBehaviour.sink.add(event);
    });
  }

  final TextFormFiledBloc fullNameBloc = TextFormFiledBloc();
  final TextFormFiledBloc facilityNameBloc = TextFormFiledBloc();
  final TextFormFiledBloc companyBloc = TextFormFiledBloc();
  final TextFormFiledBloc streetNameBloc = TextFormFiledBloc();
  final TextFormFiledBloc cityBloc = TextFormFiledBloc();
  final TextFormFiledBloc districtBloc = TextFormFiledBloc();
  final TextFormFiledBloc passwordBloc = TextFormFiledBloc();
  final TextFormFiledBloc confirmPasswordBloc = TextFormFiledBloc();
  final BehaviorSubject<NewAccountStepEnum> _stepBehaviour = BehaviorSubject();
  final ValidatorModule _validatorModule = ValidatorModule();
  final ButtonBloc buttonBloc = ButtonBloc();
  final BehaviorSubject<String> countryCodeBehaviour = BehaviorSubject();
  final BehaviorSubject<double?> _latitudeBehaviour = BehaviorSubject();
  final BehaviorSubject<double?> _longitudeBehaviour = BehaviorSubject();

  final BehaviorSubject<ApiState<List<DropDownMapper>>> _stateBehaviour =
      BehaviorSubject();

  final BehaviorSubject<ApiState<List<DropDownMapper>>> _districtBehaviour =
      BehaviorSubject();

  final BehaviorSubject<ApiState<List<DropDownMapper>>> _companyTypeBehaviour =
      BehaviorSubject();

  DropDownMapper? selectedState;
  DropDownMapper? selectedDistrict;
  DropDownMapper? selectedCompany;

  /// info recorded from preview steps

  set latitude(double? value) => _latitudeBehaviour.sink.add(value);

  set longitude(double? value) => _longitudeBehaviour.sink.add(value);

  double? get latitude =>
      _latitudeBehaviour.hasValue ? _latitudeBehaviour.value : null;

  double? get longitude =>
      _longitudeBehaviour.hasValue ? _longitudeBehaviour.value : null;

  Stream<double?> get latitudeStream => _latitudeBehaviour.stream;

  Stream<double?> get longitudeStream => _longitudeBehaviour.stream;

  Stream<bool> get validateInfoStream => Rx.combineLatest3(
    fullNameBloc.stringStream,
    facilityNameBloc.stringStream,
    companyBloc.stringStream,
    (fullName, platformName, companyType) => isNamesInfoValid,
  );

  Stream<bool> get validateLocationStream => Rx.combineLatest3(
    streetNameBloc.stringStream,
    cityBloc.stringStream,
    districtBloc.stringStream,
    (street, cityBloc, districtBloc) => isLocationValid,
  );

  Stream<bool> get validatePasswordStream => Rx.combineLatest([
    passwordBloc.stringStream,
    confirmPasswordBloc.stringStream,
  ], (value) => isPasswordValid);

  Stream<NewAccountStepEnum> get stepsStream => _stepBehaviour.stream;

  void nextStep(NewAccountStepEnum stepEnum) {
    _stepBehaviour.sink.add(stepEnum);
  }

  bool get isNamesInfoValid =>
      _validatorModule.isFiledNotEmpty(fullNameBloc.value) &&
      _validatorModule.isFiledNotEmpty(facilityNameBloc.value) &&
      selectedCompany != null;

  bool get isLocationValid =>
      _validatorModule.isFiledNotEmpty(cityBloc.value) &&
      _validatorModule.isFiledNotEmpty(districtBloc.value) &&
      (latitude != 0.0) &&
      (longitude != 0.0);

  bool get isPasswordValid =>
      _validatorModule.isPasswordValid(passwordBloc.value) &&
      _validatorModule.isMatchValid(
        passwordBloc.value,
        confirmPasswordBloc.value,
      );

  Stream<ApiState<LoginMapper>> get register => RegisterRemote(
    shopName: facilityNameBloc.value,
    name: fullNameBloc.value,
    phone: "$countryCode$mobileNumber",
    password: passwordBloc.value,
    latitude: _longitudeBehaviour.valueOrNull.toString(),
    longitude: _latitudeBehaviour.valueOrNull.toString(),
    countryId: _countryId,
    companyId: selectedCompany != null ? int.parse(selectedCompany!.id) : 0,
  ).callApiAsStream();

  Stream<ApiState<List<DropDownMapper>>> get companyStream =>
      _companyTypeBehaviour.stream;

  Stream<ApiState<LoginMapper>> updateAddress(int clientId) =>
      UpdateAddressRemote(
        clientId: clientId,
        street: streetNameBloc.value,
        street2: districtBloc.value,
        countryId: _countryId,
        city_id: int.tryParse(selectedDistrict!.id) ?? 0,
        stateId: selectedState != null ? int.parse(selectedState!.id) : 0,
        latitude: _latitudeBehaviour.valueOrNull ?? 0.0,
        longitude: _longitudeBehaviour.valueOrNull ?? 0.0,
      ).callApiAsStream();

  Stream<ApiState<List<DropDownMapper>>> get stateStream =>
      _stateBehaviour.stream;

  List<DropDownMapper> get stateList =>
      _stateBehaviour.valueOrNull?.response ?? [];

  Stream<ApiState<List<DropDownMapper>>> get districtStream =>
      _districtBehaviour.stream;

  List<DropDownMapper> get districtList =>
      _districtBehaviour.valueOrNull?.response ?? [];

  void getDistricts(int stateId, List<String> initialDistrictNames) {
    DistrictRemote(stateId).callApiAsStream().listen((event) {
      _districtBehaviour.sink.add(event);
      for (var element in event.response ?? []) {
        for (var initialName in initialDistrictNames) {
          if (element.name.toLowerCase().contains(initialName.toLowerCase())) {
            districtBloc.textFormFiledBehaviour.sink.add(
              TextEditingController(text: element.name),
            );
            districtBloc.updateStringBehaviour(element.name);
            selectedDistrict = element;
            return;
          }
        }
      }
      districtBloc.textFormFiledBehaviour.sink.add(
        TextEditingController(text: ""),
      );
      selectedDistrict = null;
      districtBloc.updateStringBehaviour("");
    });
  }

  Future<void> pickLocationInfo() async {
    var client = http.Client();
    const Map<String, String> headers = {
      "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36",
    };
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${_latitudeBehaviour.value}&lon=${_longitudeBehaviour.value}&zoom=18&addressdetails=1';
    var response = await client.get(Uri.parse(url), headers: headers);
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
    Map<dynamic, dynamic> address = decodedResponse['address'];
    _setState(address);

    String area = Apputils.getFormattedAddress(address);

    _setStreamName(area);
  }

  void _setStreamName(String area) {
    streetNameBloc.textFormFiledBehaviour.sink.add(
      TextEditingController(text: area),
    );
    streetNameBloc.updateStringBehaviour(area);
  }


  void _setState(Map<dynamic, dynamic> address) {
    if (stateList.isNotEmpty) {
      for (var element in stateList) {
        if (element.name.toLowerCase().contains(
          address['state'].toString().toLowerCase(),
        )) {
          cityBloc.textFormFiledBehaviour.sink.add(
            TextEditingController(text: element.name),
          );
          cityBloc.updateStringBehaviour(element.name);

          selectedState = element;
          getDistricts(int.tryParse(selectedState!.id) ?? 0, [
            address['neighbourhood'] ?? '',
            address['suburb'] ?? '',
          ]);

          break;
        }
      }
    }
  }

  @override
  void dispose() {

    mobileNumber = "";
    countryCode = "";
    _countryId = 0;
  }
}
