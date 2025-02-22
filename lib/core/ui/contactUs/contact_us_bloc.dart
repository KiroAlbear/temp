
import 'package:rxdart/rxdart.dart';

import '../../dto/models/baseModules/api_state.dart';
import '../../dto/models/contactUs/contact_us_mapper.dart';
import '../../dto/remote/contact_us_remote.dart';
import '../bases/bloc_base.dart';

class ContactUsBloc extends BlocBase {
  final BehaviorSubject<ApiState<ContactUsMapper>> _contactUsBehaviour =
      BehaviorSubject();
  final String closeIcon;
  final String whatsAppIcon;
  final String hotLine;
  final String facebookIcon;

  Stream<ApiState<ContactUsMapper>> get contactUsStream =>
      _contactUsBehaviour.stream;

  ContactUsBloc(
      {required this.whatsAppIcon,
      required this.facebookIcon,
      required this.closeIcon,
      required this.hotLine}) {
    ContactUsRemote().callApiAsStream().listen(
      (event) {
        _contactUsBehaviour.sink.add(event);
      },
    );
  }

  @override
  void dispose() {
    _contactUsBehaviour.close();
  }
}
