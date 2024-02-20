import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/commonBloc/drop_down_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/models/baseModules/drop_down_mapper.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/ui/bases/bloc_base.dart';

class LoginBloc extends BlocBase {
  final ButtonBloc buttonBloc = ButtonBloc();
  final TextFormFiledBloc mobileBloc = TextFormFiledBloc();
  final TextFormFiledBloc passwordBloc = TextFormFiledBloc();
  final DropDownBloc countryBloc = DropDownBloc();
  final ValidatorModule _validatorModule = ValidatorModule();

  Stream<bool> get validate => Rx.combineLatest3(
      mobileBloc.stringStream,
      passwordBloc.stringStream,
      countryBloc.selectedDropDownStream,
      (mobile, password, country) => isValid);

  bool get isValid {
    if (countryBloc.value != null) {
      return _validatorModule.isMobileValid(
              mobileBloc.value, countryBloc.value?.description ?? '') &&
          _validatorModule.isPasswordValid(passwordBloc.value);
    } else {
      return false;
    }
  }

  List<DropDownMapper> get fakeList => [
        DropDownMapper(
            name: 'Test 1',
            id: '1',
            description: '',
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'Test 2',
            id: '2',
            description: '',
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'Test 3',
            id: '3',
            description: '',
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'Test 4',
            id: '4',
            description: '',
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'Test 5',
            id: '5',
            description: '',
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'Test 6',
            id: '6',
            description: '',
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'Test 7',
            id: '7',
            description: '',
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'test 8',
            id: '8',
            description: '',
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
        DropDownMapper(
            name: 'test9',
            id: '9',
            description: '',
            image:
                'https://th.bing.com/th/id/R.d70f2a93f645082669f4bc412cc5182e?rik=ipC1NMKzHGFIvQ&riu=http%3a%2f%2fwww.theflagman.co.uk%2fwp-content%2fuploads%2f2017%2f03%2fflag-of-Egypt.jpg&ehk=%2fF3guXbzzeNmiHln3JWDor0yLWTpCec7RwlFr0nystk%3d&risl=&pid=ImgRaw&r=0'),
      ];

  @override
  void dispose() {
    buttonBloc.dispose();
    mobileBloc.dispose();
    passwordBloc.dispose();
    countryBloc.dispose();
  }
}
