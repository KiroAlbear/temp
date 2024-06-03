import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/commonBloc/drop_down_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/baseModules/drop_down_mapper.dart';
import 'package:core/dto/models/login/login_mapper.dart';
import 'package:core/dto/models/login/login_request.dart';
import 'package:core/dto/modules/constants_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/dto/remote/login_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';

class LoginBloc extends BlocBase {
  final ButtonBloc buttonBloc = ButtonBloc();
  final TextFormFiledBloc mobileBloc = TextFormFiledBloc();
  final TextFormFiledBloc passwordBloc = TextFormFiledBloc();
  final DropDownBloc countryBloc = DropDownBloc();
  final ValidatorModule _validatorModule = ValidatorModule();
  final BehaviorSubject<bool> _biometricSupportedBehaviour = BehaviorSubject()
    ..sink.add(false);

  Stream<bool> get biometricSupportedStream =>
      _biometricSupportedBehaviour.stream;

  bool get _isLoggedBefore =>
      (SharedPrefModule().userName ?? '').isNotEmpty &&
      (SharedPrefModule().password ?? '').isNotEmpty;

  LoginBloc() {
    _checkBiometricSupported();
  }

  void _checkBiometricSupported() {
    LocalAuthModule().isSupported.then((value) =>
        _biometricSupportedBehaviour.sink.add(value && _isLoggedBefore));
  }

  Stream<bool> get validate => Rx.combineLatest3(
      mobileBloc.stringStream,
      passwordBloc.stringStream,
      countryBloc.selectedDropDownStream,
      (mobile, password, country) => isValid);

  bool get isValid {
    if (countryBloc.value != null) {
      return _validatorModule.isMobileValid(
              mobileBloc.value, countryBloc.value?.customValidator ?? '') &&
          _validatorModule.isFiledNotEmpty(passwordBloc.value);
    } else {
      return false;
    }
  }

  List<DropDownMapper> get fakeList => [
        DropDownMapper(
            name: 'Test 1',
            id: '1',
            description: '+20',
            customValidator: ConstantModule.mobileRegex,
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'Test 2',
            id: '2',
            description: '+20',
            customValidator: ConstantModule.mobileRegex,
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'Test 3',
            id: '3',
            description: '+20',
            customValidator: ConstantModule.mobileRegex,
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'Test 4',
            id: '4',
            description: '+20',
            customValidator: ConstantModule.mobileRegex,
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'Test 5',
            id: '5',
            description: '+20',
            customValidator: ConstantModule.mobileRegex,
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'Test 6',
            id: '6',
            description: '+20',
            customValidator: ConstantModule.mobileRegex,
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'Test 7',
            id: '7',
            description: '+20',
            customValidator: ConstantModule.mobileRegex,
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'test 8',
            id: '8',
            description: '+20',
            customValidator: ConstantModule.mobileRegex,
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'test9',
            id: '9',
            description: '+20',
            customValidator: ConstantModule.mobileRegex,
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
      ];

  Stream<ApiState<LoginMapper>> get login => LoginRemote(
          loginRequest: LoginRequest(
              password: passwordBloc.value, phone: mobileBloc.value))
      .callApiAsStream();

  Future<bool> authenticateWithBiometric(String message) =>
      LocalAuthModule().isAuthenticated(message);

  @override
  void dispose() {
    buttonBloc.dispose();
    mobileBloc.dispose();
    passwordBloc.dispose();
    countryBloc.dispose();
  }
}
