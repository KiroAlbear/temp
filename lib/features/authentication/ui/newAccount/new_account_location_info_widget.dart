import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/generated/l10n.dart';
import 'new_account_bloc.dart';

class NewAccountLocationInfoWidget extends StatefulWidget {
  final NewAccountBloc newAccountBloc;

  const NewAccountLocationInfoWidget({super.key, required this.newAccountBloc});

  @override
  State<NewAccountLocationInfoWidget> createState() =>
      _NewAccountLocationInfoWidgetState();
}

class _NewAccountLocationInfoWidgetState
    extends State<NewAccountLocationInfoWidget> with ResponseHandlerModule {
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
  // ValueNotifier<bool> _isLocationDetected = ValueNotifier(true);

  Widget get _mapPreviewStream => StreamBuilder(
        stream: widget.newAccountBloc.latitudeStream,
        builder: (context, latitudeSnapShot) => StreamBuilder(
            stream: widget.newAccountBloc.longitudeStream,
            builder: (context, longitudeSnapShot) {
              bool showMap =
                  (latitudeSnapShot.hasData && longitudeSnapShot.hasData);
              return Stack(
                children: [
                  Opacity(
                    opacity: showMap ? 1 : 0,
                    child: MapPreviewWidget(
                      clickOnChangeLocation: () {
                        widget.newAccountBloc
                            .nextStep(NewAccountStepEnum.editLocation);
                      },
                      latitude: latitudeSnapShot.data,
                      longitude: longitudeSnapShot.data,
                      onLocationDetection: (latitude, longitude) async {
                        widget.newAccountBloc.latitude = latitude;
                        widget.newAccountBloc.longitude = longitude;

                        await widget.newAccountBloc.pickLocationInfo();
                        // _isLocationDetected.value = true;
                      },
                    ),
                  ),
                  showMap
                      ? SizedBox()
                      : Center(
                          child: Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: CircularProgressIndicator(),
                        )),
                ],
              );
            }),
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
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'^(?!\s).*$')),
        ],
        defaultTextStyle:
            RegularStyle(color: lightBlackColor, fontSize: 16.w).getStyle(),
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

  Widget get _cityTextFormFiled =>
      StreamBuilder<ApiState<List<DropDownMapper>>>(
          stream: widget.newAccountBloc.stateStream,
          initialData: LoadingState(),
          builder: (context, snapshot) =>
              checkResponseStateWithLoadingWidget(snapshot.data!, context,
                  onSuccess: CustomTextFormFiled(
                    labelText: S.of(context).enterCity,
                    defaultTextStyle:
                        RegularStyle(color: lightBlackColor, fontSize: 16.w)
                            .getStyle(),
                    textFiledControllerStream:
                        widget.newAccountBloc.cityBloc.textFormFiledStream,
                    onChanged: (value) => widget.newAccountBloc.cityBloc
                        .updateStringBehaviour(value),
                    validator: (value) =>
                        ValidatorModule().emptyValidator(context).call(value),
                    textInputType: TextInputType.none,
                    textInputAction: TextInputAction.done,
                    readOnly: true,
                    onTap: () {
                      _showStateDropDown(snapshot.data?.response ?? []);
                    },
                  )));

  void _showStateDropDown(List<DropDownMapper> list) => showModalBottomSheet(
        context: context,
        builder: (context) => CustomDropDownWidget(
          dropDownList: list,
          hasImage: false,
          onSelect: (value) {
            widget.newAccountBloc.selectedState = value;
            widget.newAccountBloc.cityBloc.textFormFiledBehaviour.sink
                .add(TextEditingController(text: value.name));
            widget.newAccountBloc.cityBloc.updateStringBehaviour(value.name);
          },
          headerText: S.of(context).chooseCity,
        ),
        backgroundColor: Colors.transparent,
        enableDrag: false,
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
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'^(?!\s).*$')),
        ],
        defaultTextStyle:
            RegularStyle(color: lightBlackColor, fontSize: 16.w).getStyle(),
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
        height: 60.h,
        textStyle:
            SemiBoldStyle(fontSize: 16.sp, color: lightBlackColor).getStyle(),
        buttonBehaviour: widget.newAccountBloc.buttonBloc.buttonBehavior,
        failedBehaviour: widget.newAccountBloc.buttonBloc.failedBehaviour,
        validateStream: widget.newAccountBloc.validateLocationStream,
      );

  Widget get _previous => CustomButtonWidget(
        idleText: S.of(context).previous,
        buttonColor: lightBlackColor,
        inLineBackgroundColor: whiteColor,
        textColor: lightBlackColor,
        height: 60.h,
        textStyle:
            SemiBoldStyle(fontSize: 16.sp, color: lightBlackColor).getStyle(),
        buttonShapeEnum: ButtonShapeEnum.outline,
        onTap: () {
          widget.newAccountBloc.nextStep(NewAccountStepEnum.info);
        },
      );
}
