
import 'package:deel/deel.dart';
import 'package:rxdart/rxdart.dart';


class ContactUsBloc extends BlocBase {
  final BehaviorSubject<ApiState<ContactUsMapper>> _contactUsBehaviour =
      BehaviorSubject();

  Stream<ApiState<ContactUsMapper>> get contactUsStream =>
      _contactUsBehaviour.stream;

  ContactUsBloc() {
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
