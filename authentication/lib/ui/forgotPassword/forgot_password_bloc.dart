import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/commonBloc/drop_down_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/baseModules/drop_down_mapper.dart';
import 'package:core/dto/modules/constants_module.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/dto/remote/country_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';

class ForgotPasswordBloc extends BlocBase{
  final DropDownBloc countryBloc = DropDownBloc();
  final ValidatorModule _validatorModule = ValidatorModule();
  final ButtonBloc buttonBloc = ButtonBloc();
  final TextFormFiledBloc mobileBloc = TextFormFiledBloc();

  Stream<bool> get validate => Rx.combineLatest2(
      mobileBloc.stringStream,
      countryBloc.selectedDropDownStream,
          (mobile, country) => isValid);

  bool get isValid {
    if (countryBloc.value != null) {
      return _validatorModule.isMobileValid(
          mobileBloc.value, countryBloc.value?.customValidator ?? '');
    } else {
      return false;
    }
  }

  Stream<ApiState<List<DropDownMapper>>> get countryStream => CountryRemote().callApiAsStream();

  @override
  void dispose() {
    buttonBloc.dispose();
    mobileBloc.dispose();
    countryBloc.dispose();
  }

}