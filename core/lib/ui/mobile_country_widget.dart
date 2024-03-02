import 'package:core/core.dart';
import 'package:core/dto/commonBloc/drop_down_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/models/baseModules/drop_down_mapper.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'custom_text_form_filed_widget.dart';

class MobileCountryWidget extends StatelessWidget {
  final DropDownBloc countryBloc;
  final TextFormFiledBloc mobileBloc;
  final List<DropDownMapper> countryList;

  const MobileCountryWidget(
      {super.key,
      required this.mobileBloc,
      required this.countryBloc,
      required this.countryList});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 7,
            child: _mobileTextFormFiled(context),
          ),
          SizedBox(
            width: 7.w,
          ),
          Flexible(flex: 3, child: _countryPicker),
        ],
      );

  Widget get _countryPicker => CountryWidget(
        countryBloc: countryBloc,
        countryList: countryList,
      );

  Widget _mobileTextFormFiled(BuildContext context) => CustomTextFormFiled(
        labelText: S.of(context).yourMobile,
        textFiledControllerStream: mobileBloc.textFormFiledStream,
        onChanged: (value) => mobileBloc.updateStringBehaviour(value),
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.number,
        validator: (value) => ValidatorModule()
            .mobileValidator(context, countryBloc.value?.customValidator)
            .call(value),
      );
}
