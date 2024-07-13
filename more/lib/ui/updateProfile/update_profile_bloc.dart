import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/commonBloc/latlong_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/update_profile/delivery_address_mapper.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/dto/remote/deliver_address_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:flutter/material.dart';

class UpdateProfileBloc extends BlocBase {
  final TextFormFiledBloc fullNameBloc = TextFormFiledBloc();
  final TextFormFiledBloc phoneBloc = TextFormFiledBloc();
  final TextFormFiledBloc buildingNameBloc = TextFormFiledBloc();
  final TextFormFiledBloc buildingNumberBloc = TextFormFiledBloc();
  final TextFormFiledBloc districtBloc = TextFormFiledBloc();
  final LatLongBloc latLongBloc = LatLongBloc();
  final TextFormFiledBloc governorateBloc = TextFormFiledBloc();
  final BehaviorSubject<ApiState<DeliveryAddressMapper>>
      _deliveryAddressBehaviour = BehaviorSubject();

  final ButtonBloc buttonBloc = ButtonBloc();

  Stream<bool> get validate => Rx.combineLatest2(
        buildingNameBloc.stringBehaviour,
        fullNameBloc.stringBehaviour,
        (a, b) => isValid,
      );

  bool get isValid =>
      ValidatorModule().isFiledNotEmpty(buildingNameBloc.value) &&
      ValidatorModule().isFiledNotEmpty(fullNameBloc.value);

  void loadDeliveryAddress() {
    DeliveryAddressRemote().callApiAsStream().listen((event) {
      _deliveryAddressBehaviour.sink.add(event);
      initAddress(event.response!);
    });
  }

  void initAddress(DeliveryAddressMapper deliveryAddress) {
    String fullAddress = deliveryAddress.street ?? '';
    // List<String> spaceSplitting = fullAddress.split(' ');
    List<String> dashSplitting = fullAddress.split('-');
    List<String> numberAndStreet = dashSplitting[0].split(' ');

    String buildingNumber = numberAndStreet[0];
    String buildingName = '';
    for (int i = 1; i < numberAndStreet.length; i++) {
      buildingName += numberAndStreet[i] + ' ';
    }

    String district = dashSplitting.length > 1 ? dashSplitting[1] : '';
    String governorate = dashSplitting.length > 2 ? dashSplitting[2] : '';

    buildingNameBloc.textFormFiledBehaviour.sink
        .add(TextEditingController(text: buildingName));
    buildingNameBloc.updateStringBehaviour(buildingName);

    buildingNumberBloc.textFormFiledBehaviour.sink
        .add(TextEditingController(text: buildingNumber));
    buildingNumberBloc.updateStringBehaviour(buildingNumber);

    districtBloc.textFormFiledBehaviour.sink
        .add(TextEditingController(text: district));
    districtBloc.updateStringBehaviour(district);

    governorateBloc.textFormFiledBehaviour.sink
        .add(TextEditingController(text: governorate));
    governorateBloc.updateStringBehaviour(governorate);

    latLongBloc.latitudeBehaviour.sink.add(deliveryAddress.latitude);
    latLongBloc.longitudeBehaviour.sink.add(deliveryAddress.longitude);
  }

  @override
  void dispose() {
    fullNameBloc.dispose();
    buildingNameBloc.dispose();
    phoneBloc.dispose();
    buildingNumberBloc.dispose();
    districtBloc.dispose();
    governorateBloc.dispose();
  }
}
