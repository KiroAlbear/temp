import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/ui/bases/bloc_base.dart';

enum NewAccountStepEnum { info, location, editLocation, password }

class NewAccountBloc extends BlocBase {
  final TextFormFiledBloc fullNameBloc = TextFormFiledBloc();
  final TextFormFiledBloc platformNameBloc = TextFormFiledBloc();
  final BehaviorSubject<NewAccountStepEnum> stepBehaviour = BehaviorSubject()
    ..sink.add(NewAccountStepEnum.info);
  final ValidatorModule _validatorModule = ValidatorModule();
  final ButtonBloc buttonBloc = ButtonBloc();

  Stream<bool> get validateInfoStream => Rx.combineLatest2(
      fullNameBloc.stringStream,
      platformNameBloc.stringStream,
      (fullName, platformName) => isInfoValid);

  bool get isInfoValid =>
      _validatorModule.isFiledNotEmpty(fullNameBloc.value) &&
      _validatorModule.isFiledNotEmpty(platformNameBloc.value);

  @override
  void dispose() {
    fullNameBloc.dispose();
    platformNameBloc.dispose();
    stepBehaviour.close();
    buttonBloc.dispose();
  }
}
