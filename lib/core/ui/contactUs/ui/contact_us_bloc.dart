
import 'package:deel/deel.dart';
import 'package:rxdart/rxdart.dart';


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
