import 'package:deel/core/generated/l10n.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';
import 'package:rxdart/rxdart.dart';

import 'new_account_bloc.dart';

class EditLocationPage extends BaseStatefulWidget {
  final NewAccountBloc newAccountBloc;
  // final double latitude;
  // final double longitude;
  const EditLocationPage({super.key, required this.newAccountBloc});

  @override
  State<EditLocationPage> createState() => _EditLocationPageState();
}

class _EditLocationPageState extends BaseState<EditLocationPage> {
  @override
  Widget getBody(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: MapModule().loadMap(
                onPicked: (latitude, longitude, city, area, address) {
                  _confirmPickLocation(
                      longitude, latitude, city, area, address);
                  // AlertModule().showDialog(
                  //   context: context,
                  //   message: S.of(context).pickLocationEnsureMessage,
                  //   cancelMessage: S.of(context).cancel,
                  //   confirmMessage: S.of(context).ok,
                  //   headerMessage: '',
                  //   onConfirm: () {
                  //     _confirmPickLocation(
                  //         longitude, latitude, city, area, address);
                  //   },
                  //   onCancel: () {
                  //     ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  //   },
                  // );
                },
                latitude: widget.newAccountBloc.latitude,
                longitude: widget.newAccountBloc.longitude,
                hintText: S.of(context).locationYourLocation,
                buttonText: S.of(context).confirm),
          ),
        ),
      );

  /* Widget _cancelButton(BuildContext context) =>
      CustomButtonWidget(
          idleText: S
              .of(context)
              .cancel,
          height: 30.h,
          onTap: () {

          },
          inLineBackgroundColor: whiteColor,
          textColor: secondaryColor,
          buttonShapeEnum: ButtonShapeEnum.outline);

  Widget _confirmButton(BuildContext context, double longitude, double latitude,
      String city, String area, String address) =>
      CustomButtonWidget(
        idleText: S
            .of(context)
            .ok,
        height: 30.h,
        onTap: () =>
        ,
      );*/

  void _confirmPickLocation(double longitude, double latitude, String city,
      String area, String address) {
    // ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    widget.newAccountBloc.longitude = longitude;
    widget.newAccountBloc.latitude = latitude;
    if (area.isNotEmpty) {
      widget.newAccountBloc.neighborhoodBloc.textFormFiledBehaviour.sink
          .add(TextEditingController(text: area));
      widget.newAccountBloc.neighborhoodBloc.updateStringBehaviour(area);
    }

    widget.newAccountBloc.streetNameBloc.textFormFiledBehaviour.sink
        .add(TextEditingController(text: address));
    widget.newAccountBloc.streetNameBloc.updateStringBehaviour(address);
    widget.newAccountBloc.nextStep(NewAccountStepEnum.locationInfo);
    for (var element in widget.newAccountBloc.stateList) {
      if (element.name.toLowerCase().contains(city.toLowerCase())) {
        widget.newAccountBloc.cityBloc.textFormFiledBehaviour.sink
            .add(TextEditingController(text: element.name));
        widget.newAccountBloc.cityBloc.updateStringBehaviour(element.name);
        widget.newAccountBloc.selectedState = element;
        break;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pop(context);
    },);
  }

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;
}
