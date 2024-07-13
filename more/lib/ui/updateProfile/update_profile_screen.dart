import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:core/ui/custom_text_form_filed_widget.dart';
import 'package:core/ui/mapPreview/map_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:more/ui/more/more_bloc.dart';
import 'package:more/ui/updateProfile/update_profile_bloc.dart';

class UpdateProfileScreen extends BaseStatefulWidget {
  final String backIcon;
  final MoreBloc moreBloc;


  const UpdateProfileScreen(
      {required this.backIcon, required this.moreBloc, super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends BaseState<UpdateProfileScreen> {

  final UpdateProfileBloc _bloc = UpdateProfileBloc();
  final double _headerSpacing = 12.h;
  final double _textfieldsSpacing = 15.h;
  final double _textfieldsLabelSpacing = 8.h;
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  @override
  void initState() {
    super.initState();
    _bloc.fullNameBloc.textFormFiledBehaviour.sink.add(TextEditingController(text: widget.moreBloc.user.name.split('-')[0]));
    _bloc.fullNameBloc.updateStringBehaviour(widget.moreBloc.user.name.split('-')[0]);
  }

  @override
  Widget getBody(BuildContext context) {
    return Column(children: [
      AppTopWidget(
        title: S.of(context).updateProfileTitle,
        notificationIcon: '',
        homeLogo: '',
        scanIcon: '',
        searchIcon: '',
        supportIcon: '',
        hideTop: true,
        backIcon: widget.backIcon,
      ),
      SizedBox(
        height: 15,
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: S.of(context).updateProfilePersonalData,
                    customTextStyle:
                        BoldStyle(fontSize: 24.sp, color: lightBlackColor)),
                SizedBox(
                  height: _headerSpacing,
                ),
                _nameTextField(context),
                SizedBox(
                  height: _textfieldsSpacing,
                ),
                _phoneTextField(context),
                SizedBox(
                  height: _textfieldsSpacing,
                ),
                CustomText(
                    text: S.of(context).updateProfileBuildingData,
                    customTextStyle:
                        BoldStyle(fontSize: 24.sp, color: lightBlackColor)),
                SizedBox(
                  height: _headerSpacing,
                ),
                _buildingNameTextField(context),
                SizedBox(
                  height: _textfieldsSpacing,
                ),
                _locationView(context),
                SizedBox(
                  height: _textfieldsSpacing,
                ),
                _buildingNumberTextField(context),
                SizedBox(
                  height: _textfieldsSpacing,
                ),
                Row(
                  children: [
                    Expanded(child: _districtTextField(context)),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(child: _governorateTextField(context)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0, top: 33.0),
                  child: CustomButtonWidget(
                      idleText: S.of(context).save,
                      onTap: () {
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }

  CustomText _label(String text) {
    return CustomText(
        text: text,
        customTextStyle: RegularStyle(fontSize: 20.sp, color: lightBlackColor));
  }

  Column _nameTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(S.of(context).fullName),
        SizedBox(
          height: _textfieldsLabelSpacing,
        ),
        CustomTextFormFiled(
          labelText: S.of(context).fullName,
          defaultTextStyle: _getTextStyle(),
          textFiledControllerStream: widget.bloc.nameBehavior.stream,
          onChanged: (value) => widget.bloc.updateName(value),
          validator: (value) =>
              ValidatorModule().emptyValidator(context).call(value),
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  Column _phoneTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(S.of(context).enterMobileNumber),
        SizedBox(
          height: _textfieldsLabelSpacing,
        ),
        CustomTextFormFiled(
          fillColor: greyColor.withOpacity(0.5),
          defaultTextStyle: _getTextStyle(),
          readOnly: true,
          labelText: S.of(context).enterMobileNumber,
          textFiledControllerStream: _bloc.mobileNameBloc.textFormFiledBehaviour,
          onChanged: (value) => _bloc.mobileNameBloc.updateStringBehaviour(value),
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  Column _locationView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(S.of(context).updateProfileLocation),
        SizedBox(
          height: _textfieldsLabelSpacing,
        ),
        MapPreviewWidget(
          latitude: widget.bloc.locationBehavior.stream.value.latitude,
          longitude: widget.bloc.locationBehavior.stream.value.longitude,
          showEditLocation: false,
          clickOnChangeLocation: () {},
        )
      ],
    );
  }

  Column _buildingNameTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(S.of(context).updateProfileBuildingName),
        SizedBox(
          height: _textfieldsLabelSpacing,
        ),
        CustomTextFormFiled(
          labelText: S.of(context).updateProfileBuildingName,
          defaultTextStyle: _getTextStyle(),
          textFiledControllerStream: widget.bloc.buildingNameBehavior.stream,
          onChanged: (value) => widget.bloc.updateBuildingName(value),
          validator: (value) =>
              ValidatorModule().emptyValidator(context).call(value),
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Column _buildingNumberTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(S.of(context).updateProfileBuildingNumber),
        SizedBox(
          height: _textfieldsLabelSpacing,
        ),
        CustomTextFormFiled(
          readOnly: true,
          labelText: S.of(context).updateProfileBuildingNumber,
          defaultTextStyle: _getTextStyle(),
          textFiledControllerStream: widget.bloc.buildingNumberBehavior.stream,
          onChanged: (value) => (),
          validator: (value) {
            return null;
          },
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Column _districtTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(S.of(context).updateProfileDistrict),
        SizedBox(
          height: _textfieldsLabelSpacing,
        ),
        CustomTextFormFiled(
          readOnly: true,
          labelText: S.of(context).updateProfileDistrict,
          defaultTextStyle: _getTextStyle(),
          textFiledControllerStream: widget.bloc.districtBehavior.stream,
          onChanged: (value) => (),
          validator: (value) {
            return null;
          },
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Column _governorateTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(S.of(context).updateProfileGovernorate),
        SizedBox(
          height: _textfieldsLabelSpacing,
        ),
        CustomTextFormFiled(
          readOnly: true,
          labelText: S.of(context).updateProfileGovernorate,
          defaultTextStyle: _getTextStyle(),
          textFiledControllerStream: widget.bloc.governorateBehavior.stream,
          onChanged: (value) => (),
          validator: (value) {
            return null;
          },
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  TextStyle _getTextStyle() {
    return RegularStyle(fontSize: 16.sp, color: lightBlackColor).getStyle();
  }
}
