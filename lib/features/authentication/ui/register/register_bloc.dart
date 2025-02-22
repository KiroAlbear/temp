import 'package:deel/deel.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends BlocBase {
  final TextFormFiledBloc mobileBloc = TextFormFiledBloc();
  final DropDownBloc countryBloc = DropDownBloc();
  final ValidatorModule _validatorModule = ValidatorModule();
  final ButtonBloc buttonBloc = ButtonBloc();

  final BehaviorSubject<ApiState<List<DropDownMapper>>> _countryBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  RegisterBloc() {
    CountryRemote().callApiAsStream().listen(
      (event) {
        _countryBehaviour.sink.add(event);
      },
    );
  }

  Stream<bool> get validate => Rx.combineLatest2(mobileBloc.stringStream,
      countryBloc.selectedDropDownStream, (mobile, country) => isValid);

  bool get isValid {
    if (countryBloc.value != null) {
      return _validatorModule.isMobileValid(
          mobileBloc.value, countryBloc.value?.customValidator ?? '');
    } else {
      return false;
    }
  }

  Stream<ApiState<List<DropDownMapper>>> get countryStream =>
      _countryBehaviour.stream;

  Stream<ApiState<bool>> get checkPhone =>
      CheckPhoneRemote("+${countryBloc.value!.description}${mobileBloc.value}")
          .callApiAsStream();

  @override
  void dispose() {
    countryBloc.dispose();
    mobileBloc.dispose();
    buttonBloc.dispose();
  }
}
