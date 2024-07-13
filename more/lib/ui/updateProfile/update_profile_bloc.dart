import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/ui/bases/bloc_base.dart';

class UpdateProfileBloc extends BlocBase {
  final TextFormFiledBloc fullNameBloc = TextFormFiledBloc();
  final TextFormFiledBloc shopNameBloc = TextFormFiledBloc();
  final TextFormFiledBloc mobileNameBloc = TextFormFiledBloc();
  final TextFormFiledBloc streetNameBloc = TextFormFiledBloc();
  final TextFormFiledBloc districtBloc = TextFormFiledBloc();

  final TextFormFiledBloc cityNameBloc = TextFormFiledBloc();

  final ButtonBloc buttonBloc = ButtonBloc();

  Stream<bool> get validate => Rx.combineLatest2(
        shopNameBloc.stringBehaviour,
        fullNameBloc.stringBehaviour,
        (a, b) => isValid,
      );

  bool get isValid =>
      ValidatorModule().isFiledNotEmpty(shopNameBloc.value) &&
      ValidatorModule().isFiledNotEmpty(fullNameBloc.value);

  @override
  void dispose() {
    fullNameBloc.dispose();
    shopNameBloc.dispose();
    mobileNameBloc.dispose();
    streetNameBloc.dispose();
    districtBloc.dispose();
    cityNameBloc.dispose();
  }
}
