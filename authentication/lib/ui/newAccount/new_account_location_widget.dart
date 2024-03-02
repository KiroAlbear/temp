import 'package:authentication/ui/newAccount/new_account_bloc.dart';
import 'package:core/core.dart';
import 'package:core/dto/modules/alert_module.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_material_banner.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

class NewAccountLocationWidget extends StatefulWidget {
  final NewAccountBloc newAccountBloc;

  const NewAccountLocationWidget({super.key, required this.newAccountBloc});

  @override
  State<NewAccountLocationWidget> createState() =>
      _NewAccountLocationWidgetState();
}

class _NewAccountLocationWidgetState extends State<NewAccountLocationWidget> {
  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.h,
          ),
          CustomText(
              text: S.of(context).selectLocation,
              customTextStyle:
                  RegularStyle(color: secondaryColor, fontSize: 20.sp)),
          SizedBox(
            height: 12.h,
          ),
          MapModule().loadMap(
              onPicked: (latitude, longitude, city, area, address) {
                AlertModule().showCenterDialog(
                  context: context,
                  message: S.of(context).pickLocationEnsureMessage,
                  cancelMessage: S.of(context).cancel,
                  confirmMessage: S.of(context).ok,
                  headerMessage: '',
                  onConfirm: () {
                    _confirmPickLocation(
                        longitude, latitude, city, area, address);
                  },
                  onCancel: () {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  },
                );
              },
              hintText: S.of(context).locationYourLocation,
              buttonText: S.of(context).selectLocation)
        ],
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
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    widget.newAccountBloc.longitude = longitude;
    widget.newAccountBloc.latitude = latitude;
    widget.newAccountBloc.cityBloc.textFormFiledBehaviour.sink
        .add(TextEditingController(text: city));
    widget.newAccountBloc.cityBloc.updateStringBehaviour(city);
    widget.newAccountBloc.neighborhoodBloc.textFormFiledBehaviour.sink
        .add(TextEditingController(text: area));
    widget.newAccountBloc.neighborhoodBloc.updateStringBehaviour(area);
    widget.newAccountBloc.streetNameBloc.textFormFiledBehaviour.sink
        .add(TextEditingController(text: address));
    widget.newAccountBloc.streetNameBloc.updateStringBehaviour(address);
    widget.newAccountBloc.nextStep(NewAccountStepEnum.locationInfo);
  }
}
