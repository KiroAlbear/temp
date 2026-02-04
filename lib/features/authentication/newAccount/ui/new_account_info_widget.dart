import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'new_account_bloc.dart';

class NewAccountInfoWidget extends BaseStatefulWidget {
  final NewAccountBloc newAccountBloc;

  const NewAccountInfoWidget({super.key, required this.newAccountBloc});

  @override
  State<NewAccountInfoWidget> createState() => _NewAccountInfoWidgetState();
}

class _NewAccountInfoWidgetState extends BaseState<NewAccountInfoWidget> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

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
      SizedBox(height: 12.h),
      CustomText(
        text: Loc.of(context)!.threeFullName,
        customTextStyle: MediumStyle(fontSize: 16.sp, color: secondaryColor),
      ),
      SizedBox(height: 12.h),
      _fullNameTextFiled,
      SizedBox(height: 24.h),
      CustomText(
        text: Loc.of(context)!.platformName,
        customTextStyle: MediumStyle(fontSize: 16.sp, color: secondaryColor),
      ),
      SizedBox(height: 12.h),
      _platformNameTextFiled,
      SizedBox(height: 24.h),
      CustomText(
        text: Loc.of(context)!.platformType,
        customTextStyle: MediumStyle(fontSize: 16.sp, color: secondaryColor),
      ),
      SizedBox(height: 12.h),
      _companyTextFormFiled,
    ],
  );

  Widget get _fullNameTextFiled => CustomTextFormFiled(
    defaultTextStyle: RegularStyle(
      color: lightBlackColor,
      fontSize: 16.w,
    ).getStyle(),
    labelText: Loc.of(context)!.enterFullName,
    textFiledControllerStream:
        widget.newAccountBloc.fullNameBloc.textFormFiledStream,
    onChanged: (value) =>
        widget.newAccountBloc.fullNameBloc.updateStringBehaviour(value),
    validator: (value) => ValidatorModule().emptyValidator(context).call(value),
    inputFormatter: [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\u0621-\u064a-\ ]')),
      FilteringTextInputFormatter.allow(RegExp(r'^(?!\s).*$')),
    ],
    textInputAction: TextInputAction.next,
  );

  Widget get _platformNameTextFiled => CustomTextFormFiled(
    labelText: Loc.of(context)!.platformName,
    defaultTextStyle: RegularStyle(
      color: lightBlackColor,
      fontSize: 16.w,
    ).getStyle(),
    textFiledControllerStream:
        widget.newAccountBloc.facilityNameBloc.textFormFiledStream,
    onChanged: (value) =>
        widget.newAccountBloc.facilityNameBloc.updateStringBehaviour(value),
    validator: (value) => ValidatorModule().emptyValidator(context).call(value),
    inputFormatter: [
      FilteringTextInputFormatter.allow(
        RegExp(r'[a-z0-9\A-Z\u0621-\u064a-\u0660-\u0669 ]'),
      ),
      FilteringTextInputFormatter.allow(RegExp(r'^(?!\s).*$')),
      // FilteringTextInputFormatter.allow(RegExp(r'^[\u0660-\u0669]+$')),
    ],
    textInputAction: TextInputAction.next,
  );

  Widget get _companyTextFormFiled =>
      StreamBuilder<ApiState<List<DropDownMapper>>>(
        stream: widget.newAccountBloc.companyStream,
        initialData: LoadingState(),
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
          snapshot.data!,
          context,
          onSuccess: CustomTextFormFiled(
            labelText: Loc.of(context)!.platformType,
            defaultTextStyle: RegularStyle(
              color: lightBlackColor,
              fontSize: 16.w,
            ).getStyle(),
            textFiledControllerStream:
                widget.newAccountBloc.companyBloc.textFormFiledStream,
            onChanged: (value) =>
                widget.newAccountBloc.companyBloc.updateStringBehaviour(value),
            validator: (value) =>
                ValidatorModule().emptyValidator(context).call(value),
            textInputType: TextInputType.none,
            textInputAction: TextInputAction.done,
            readOnly: true,
            isDropDownMenu: true,
            onTap: () {
              _showCompanyDropDown(snapshot.data?.response ?? []);
            },
          ),
        ),
      );

  void _showCompanyDropDown(List<DropDownMapper> list) => showModalBottomSheet(
    context: context,
    builder: (context) => CustomDropDownWidget(
      dropDownList: list,
      hasImage: false,
      onSelect: (value) {
        widget.newAccountBloc.selectedCompany = value;
        widget.newAccountBloc.companyBloc.textFormFiledBehaviour.sink.add(
          TextEditingController(text: value.name),
        );
        widget.newAccountBloc.companyBloc.updateStringBehaviour(value.name);
      },
      headerText: Loc.of(context)!.choosePlatformType,
    ),
    backgroundColor: Colors.transparent,
    enableDrag: false,
  );
}
