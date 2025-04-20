import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../dto/commonBloc/drop_down_bloc.dart';
import '../dto/commonBloc/text_form_filed_bloc.dart';
import '../dto/models/baseModules/drop_down_mapper.dart';
import '../dto/modules/app_color_module.dart';
import '../dto/modules/custom_text_style_module.dart';
import '../dto/modules/validator_module.dart';
import '../generated/l10n.dart';
import 'country_widget.dart';
import 'custom_text_form_filed_widget.dart';

class MobileCountryWidget extends StatelessWidget {
  final DropDownBloc countryBloc;
  final TextFormFiledBloc mobileBloc;
  final List<DropDownMapper> countryList;
  final bool enableValidator;
  final Key? key;

  const MobileCountryWidget(
      {this.key,
      required this.mobileBloc,
      required this.countryBloc,
      required this.countryList,
      this.enableValidator = true});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _countryPicker,
          SizedBox(
            width: 7.w,
          ),
          Expanded(child: _mobileTextFormFiled(context)),

        ],
      );

  Widget get _countryPicker => CountryWidget(
        countryBloc: countryBloc,
        countryList: countryList,
      );

  Widget _mobileTextFormFiled(BuildContext context) => CustomTextFormFiled(
        key: key,
        labelText: S.of(context).yourMobile,
        textFiledControllerStream: mobileBloc.textFormFiledStream,
        onChanged: (value) => mobileBloc.updateStringBehaviour(value),
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.number,
        inputFormatter: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        defaultTextStyle:
            RegularStyle(fontSize: 16.sp, color: lightBlackColor).getStyle(),
        validator: enableValidator
            ? (value) => ValidatorModule()
                .mobileValidator(context, countryBloc.value?.mobileValidator)
                .call(value)
            : null,
      );
}
