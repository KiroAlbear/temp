import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/commonBloc/latlong_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/update_profile/delivery_address_mapper.dart';
import 'package:core/dto/models/update_profile/update_profile_request.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/dto/remote/deliver_address_remote.dart';
import 'package:core/dto/remote/update_profile_remote.dart';
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
  final BehaviorSubject<int> clientIDBehaviour = BehaviorSubject();
  final BehaviorSubject<int> countryIdBehaviour = BehaviorSubject();
  final BehaviorSubject<int> stateIdBehaviour = BehaviorSubject();
  final BehaviorSubject<String> clientEmailBehaviour = BehaviorSubject();

  final BehaviorSubject<ApiState<DeliveryAddressMapper>>
      deliveryAddressBehaviour = BehaviorSubject();

  Stream<ApiState<void>> updateProfile() {
    if (fullNameBloc.textFormFiledBehaviour.value.text.isNotEmpty &&
        buildingNameBloc.textFormFiledBehaviour.value.text.isNotEmpty) {
      return UpdateProfiledRemote(
        body: UpdateProfileRequestBody(
          clientId: clientIDBehaviour.value,
          email: clientEmailBehaviour.value,
          mobile: phoneBloc.value,
          name: fullNameBloc.value,
          shopName: buildingNameBloc.value,
          district: districtBloc.value,
          city: governorateBloc.value,
          street: buildingNumberBloc.value,
          country_id: countryIdBehaviour.value,
          state_id: stateIdBehaviour.value,
          partner_latitude: latLongBloc.latitudeBehaviour.value,
          partner_longitude: latLongBloc.longitudeBehaviour.value,
        ),
      ).callApiAsStream();
    } else
      return Stream.value(IdleState());
  }

  final ButtonBloc buttonBloc = ButtonBloc();

  Stream<bool> get validate => Rx.combineLatest2(
        buildingNameBloc.stringBehaviour,
        fullNameBloc.stringBehaviour,
        (a, b) => isValid,
      );

  bool get isValid =>
      ValidatorModule().isFiledNotEmpty(buildingNameBloc.value) &&
      ValidatorModule().isFiledNotEmpty(fullNameBloc.value);

  void loadDeliveryAddress(String userId) {
    DeliveryAddressRemote(userId).callApiAsStream().listen((event) {
      deliveryAddressBehaviour.sink.add(event);
      initAddress(event.response!);
    });
  }

  void initAddress(DeliveryAddressMapper deliveryAddress) {
    // String fullAddress = deliveryAddress.street ?? '';
    // // List<String> spaceSplitting = fullAddress.split(' ');
    // List<String> dashSplitting = fullAddress.split('-');
    // List<String> numberAndStreet = dashSplitting[0].split(' ');

    String buildingNumber = deliveryAddress.street;
    // String buildingName = '';
    // for (int i = 1; i < numberAndStreet.length; i++) {
    //   buildingName += numberAndStreet[i] + ' ';
    // }

    String district = deliveryAddress.street2;
    String governorate = deliveryAddress.city ?? '';

    // buildingNameBloc.textFormFiledBehaviour.sink
    //     .add(TextEditingController(text: buildingName));
    // buildingNameBloc.updateStringBehaviour(buildingName);

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
