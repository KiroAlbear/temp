import 'package:authentication/ui/newAccount/new_account_bloc.dart';
import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:core/ui/custom_text_form_filed_widget.dart';
import 'package:core/ui/mapPreview/map_preview_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewAccountLocationInfoWidget extends StatefulWidget {
  final NewAccountBloc newAccountBloc;

  const NewAccountLocationInfoWidget({super.key, required this.newAccountBloc});

  @override
  State<NewAccountLocationInfoWidget> createState() =>
      _NewAccountLocationInfoWidgetState();
}

class _NewAccountLocationInfoWidgetState
    extends State<NewAccountLocationInfoWidget> {
  @override
  Widget build(BuildContext context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            CustomText(
                text: S.of(context).selectLocation,
                customTextStyle:
                    RegularStyle(color: lightBlackColor, fontSize: 20.sp)),
            SizedBox(
              height: 12.h,
            ),
            _mapPreviewStream,
            SizedBox(
              height: 12.h,
            ),
            CustomText(
                text: S.of(context).streetName,
                customTextStyle: RegularStyle(
                  color: lightBlackColor,
                  fontSize: 20.sp,
                )),
            SizedBox(
              height: 12.h,
            ),
            _streetNameTextFormFiled,
            SizedBox(
              height: 24.h,
            ),
            _cityAndDistrictRow,
            SizedBox(
              height: 21.h,
            ),
            _nextPreviousButton,
            SizedBox(
              height: 21.h,
            ),
          ]);

  Widget get _mapPreviewStream => StreamBuilder(
        stream: widget.newAccountBloc.latitudeStream,
        builder: (context, latitudeSnapShot) => StreamBuilder(
          stream: widget.newAccountBloc.longitudeStream,
          builder: (context, longitudeSnapShot) => MapPreviewWidget(
            clickOnChangeLocation: () {
              widget.newAccountBloc.nextStep(NewAccountStepEnum.editLocation);
            },
            latitude: latitudeSnapShot.data,
            longitude: longitudeSnapShot.data,
          ),
        ),
      );

  Widget get _streetNameTextFormFiled => CustomTextFormFiled(
        labelText: S.of(context).enterStreetName,
        textFiledControllerStream:
            widget.newAccountBloc.streetNameBloc.textFormFiledStream,
        onChanged: (value) =>
            widget.newAccountBloc.streetNameBloc.updateStringBehaviour(value),
        validator: (value) =>
            ValidatorModule().emptyValidator(context).call(value),
        textInputType: TextInputType.text,
        textInputAction: TextInputAction.next,
      );

  Widget get _cityAndDistrictRow => Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: S.of(context).neighborhood,
                    customTextStyle: RegularStyle(
                      color: lightBlackColor,
                      fontSize: 20.sp,
                    )),
                SizedBox(
                  height: 12.h,
                ),
                _districtTextFormFiled,
              ],
            ),
          ),
          SizedBox(
            width: 9.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: S.of(context).city,
                    customTextStyle: RegularStyle(
                      color: lightBlackColor,
                      fontSize: 20.sp,
                    )),
                SizedBox(
                  height: 12.h,
                ),
                _cityTextFormFiled,
              ],
            ),
          ),
        ],
      );

  Widget get _cityTextFormFiled => CustomTextFormFiled(
        labelText: S.of(context).enterCity,
        textFiledControllerStream:
            widget.newAccountBloc.cityBloc.textFormFiledStream,
        onChanged: (value) =>
            widget.newAccountBloc.cityBloc.updateStringBehaviour(value),
        validator: (value) =>
            ValidatorModule().emptyValidator(context).call(value),
        textInputType: TextInputType.text,
        textInputAction: TextInputAction.next,
      );

  Widget get _districtTextFormFiled => CustomTextFormFiled(
        labelText: S.of(context).enterNeighborhood,
        textFiledControllerStream:
            widget.newAccountBloc.neighborhoodBloc.textFormFiledStream,
        onChanged: (value) =>
            widget.newAccountBloc.neighborhoodBloc.updateStringBehaviour(value),
        validator: (value) =>
            ValidatorModule().emptyValidator(context).call(value),
        textInputType: TextInputType.text,
        textInputAction: TextInputAction.next,
      );

  Widget get _nextPreviousButton => Row(
        children: [
          Expanded(child: _previous),
          SizedBox(
            width: 9.w,
          ),
          Expanded(child: _nextButton),
        ],
      );

  Widget get _nextButton => CustomButtonWidget(
        idleText: S.of(context).next,
        onTap: () {
          if (widget.newAccountBloc.isLocationValid) {
            widget.newAccountBloc.nextStep(NewAccountStepEnum.password);
          }
        },
        buttonBehaviour: widget.newAccountBloc.buttonBloc.buttonBehavior,
        failedBehaviour: widget.newAccountBloc.buttonBloc.failedBehaviour,
        validateStream: widget.newAccountBloc.validateLocationStream,
      );

  Widget get _previous => CustomButtonWidget(
        idleText: S.of(context).previous,
        buttonColor: lightBlackColor,
        inLineBackgroundColor: whiteColor,
        textColor: lightBlackColor,
        buttonShapeEnum: ButtonShapeEnum.outline,
        onTap: () {
          widget.newAccountBloc.nextStep(NewAccountStepEnum.info);
        },
      );
}
