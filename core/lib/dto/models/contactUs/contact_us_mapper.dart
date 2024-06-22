import 'package:core/dto/models/contactUs/contact_us_response.dart';

class ContactUsMapper {
  late final String whatsApp;
  late final String hotLine;
  late final String facebook;

  void init(ContactUsResponse response) {
    switch ((response.type ?? '')) {
      case 'Hotline':
        hotLine = response.contact ?? '';
        break;
      case 'WhatsApp':
        whatsApp = response.contact ?? '';
        break;
      case 'Facebook':
        facebook = response.contact ?? '';
        break;
    }
  }
}
