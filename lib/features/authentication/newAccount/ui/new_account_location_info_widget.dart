import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewAccountLocationInfoWidget extends BaseStatefulWidget {
  final NewAccountBloc newAccountBloc;

  const NewAccountLocationInfoWidget({super.key, required this.newAccountBloc});

  @override
  BaseState<NewAccountLocationInfoWidget> createState() =>
      _NewAccountLocationInfoWidgetState();
}

class _NewAccountLocationInfoWidgetState
    extends BaseState<NewAccountLocationInfoWidget> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  bool isSafeArea() => false;

  @override
  bool get useCustomScaffold => true;

  @override
  Color? systemNavigationBarColor() => Colors.white;

  @override
  Color? statusBarColor() => Colors.white;

  @override
  double appTopPadding() => 0;

  @override
  Widget getBody(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 30.h),
      CustomText(
        text: Loc.of(context)!.selectLocation,
        customTextStyle: MediumStyle(color: secondaryColor, fontSize: 16.sp),
      ),
      SizedBox(height: 12.h),
      _mapPreviewStream,
      SizedBox(height: 12.h),
      CustomText(
        text: Loc.of(context)!.streetName,
        customTextStyle: MediumStyle(color: secondaryColor, fontSize: 16.sp),
      ),
      SizedBox(height: 12.h),
      _streetNameTextFormFiled,
      SizedBox(height: 24.h),
      _cityAndDistrictRow,
    ],
  );

  Widget get _mapPreviewStream => StreamBuilder(
    stream: widget.newAccountBloc.latitudeStream,
    builder: (context, latitudeSnapShot) => StreamBuilder(
      stream: widget.newAccountBloc.longitudeStream,
      builder: (context, longitudeSnapShot) {
        bool showMap = (latitudeSnapShot.hasData && longitudeSnapShot.hasData);
        return Stack(
          children: [
            Opacity(
              opacity: showMap ? 1 : 0,
              child: MapPreviewWidget(
                clickOnChangeLocation: () {

                  Routes.navigateToScreen(
                    Routes.editLocationPage,
                    NavigationType.pushNamed,
                    context,
                    extra: widget.newAccountBloc,
                  );
                },
                latitude: latitudeSnapShot.data,
                longitude: longitudeSnapShot.data,
                onLocationDetection: (latitude, longitude) async {
                  widget.newAccountBloc.latitude = latitude;
                  widget.newAccountBloc.longitude = longitude;

                  await widget.newAccountBloc.pickLocationInfo();
                },
              ),
            ),
            showMap
                ? SizedBox()
                : Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ],
        );
      },
    ),
  );

  Widget get _streetNameTextFormFiled => CustomTextFormFiled(
    labelText: Loc.of(context)!.enterStreetName,
    textFiledControllerStream:
        widget.newAccountBloc.streetNameBloc.textFormFiledStream,
    onChanged: (value) =>
        widget.newAccountBloc.streetNameBloc.updateStringBehaviour(value),
    validator: (value) => ValidatorModule().emptyValidator(context).call(value),
    textInputType: TextInputType.text,
    inputFormatter: [FilteringTextInputFormatter.allow(RegExp(r'^(?!\s).*$'))],
    defaultTextStyle: RegularStyle(
      color: lightBlackColor,
      fontSize: 16.sp,
    ).getStyle(),
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
              text: Loc.of(context)!.city,
              customTextStyle: MediumStyle(
                color: secondaryColor,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 12.h),
            _cityTextFormFiled,
          ],
        ),
      ),

      SizedBox(width: 9.w),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: Loc.of(context)!.neighborhood,
              customTextStyle: MediumStyle(
                color: secondaryColor,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 12.h),
            _districtTextFormFiled,
          ],
        ),
      ),
    ],
  );

  Widget get _cityTextFormFiled =>
      StreamBuilder<ApiState<List<DropDownMapper>>>(
        stream: widget.newAccountBloc.stateStream,
        initialData: LoadingState(),
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
          snapshot.data!,
          context,
          onSuccess: CustomTextFormFiled(
            labelText: Loc.of(context)!.enterCity,
            defaultTextStyle: RegularStyle(
              color: lightBlackColor,
              fontSize: 16.w,
            ).getStyle(),
            textFiledControllerStream:
                widget.newAccountBloc.cityBloc.textFormFiledStream,
            onChanged: (value) =>
                widget.newAccountBloc.cityBloc.updateStringBehaviour(value),
            validator: (value) =>
                ValidatorModule().emptyValidator(context).call(value),
            textInputType: TextInputType.none,
            textInputAction: TextInputAction.done,
            readOnly: true,
            isDropDownMenu: true,
            onTap: () {
              _showStateDropDown(snapshot.data?.response ?? []);
            },
          ),
        ),
      );

  void _showStateDropDown(List<DropDownMapper> list) => showModalBottomSheet(
    context: context,
    builder: (context) => CustomDropDownWidget(
      dropDownList: list,
      hasImage: false,
      onSelect: (value) {
        widget.newAccountBloc.getDistricts(int.tryParse(value.id) ?? -1, []);
        widget.newAccountBloc.selectedState = value;
        widget.newAccountBloc.cityBloc.textFormFiledBehaviour.sink.add(
          TextEditingController(text: value.name),
        );
        widget.newAccountBloc.cityBloc.updateStringBehaviour(value.name);
      },
      headerText: Loc.of(context)!.chooseCity,
    ),
    backgroundColor: Colors.transparent,
    enableDrag: false,
  );

  Widget get _districtTextFormFiled =>
      StreamBuilder<ApiState<List<DropDownMapper>>>(
        stream: widget.newAccountBloc.districtStream,
        initialData: LoadingState(),
        builder: (context, snapshot) {
          return checkResponseStateWithLoadingWidget(
            snapshot.data!,
            context,
            onSuccess: CustomTextFormFiled(
              labelText: Loc.of(context)!.enterNeighborhood,
              textFiledControllerStream:
                  widget.newAccountBloc.districtBloc.textFormFiledStream,
              onChanged: (value) => widget.newAccountBloc.districtBloc
                  .updateStringBehaviour(value),
              validator: (value) =>
                  ValidatorModule().emptyValidator(context).call(value),
              textInputType: TextInputType.text,
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'^(?!\s).*$')),
              ],
              isDropDownMenu: true,
              readOnly: true,
              onTap: () {
                _showDistrictDropDown(snapshot.data?.response ?? []);
              },
              defaultTextStyle: MediumStyle(
                color: lightBlackColor,
                fontSize: 16.sp,
              ).getStyle(),
              textInputAction: TextInputAction.next,
            ),
          );
        },
      );

  void _showDistrictDropDown(List<DropDownMapper> list) => showModalBottomSheet(
    context: context,
    builder: (context) => CustomDropDownWidget(
      dropDownList: list,
      hasImage: false,
      onSelect: (value) {
        widget.newAccountBloc.selectedDistrict = value;
        widget.newAccountBloc.districtBloc.textFormFiledBehaviour.sink.add(
          TextEditingController(text: value.name),
        );
        widget.newAccountBloc.districtBloc.updateStringBehaviour(value.name);
      },
      headerText: Loc.of(context)!.chooseDistrict,
    ),
    backgroundColor: Colors.transparent,
    enableDrag: false,
  );
}
