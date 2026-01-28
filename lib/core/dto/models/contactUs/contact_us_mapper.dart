import 'contact_us_response.dart';

class ContactUsMapper {
  String whatsApp = "";
  String hotLine = "";
  String facebook = "";
  String instagram = "";
  String tiktok = "";

  static const int HotlineType = 1;
  static const int WhatsAppType = 2;
  static const int FacebookType = 3;
  static const int InstagramType = 4;
  static const int TiktokType = 5;

  void init(ContactUsResponse response) {
    switch ((response.type ?? 0)) {
      case HotlineType:
        hotLine = response.contact ?? '';
        break;
      case WhatsAppType:
        whatsApp = response.contact ?? '';
        break;
      case FacebookType:
        facebook = response.contact ?? '';
        break;
      case InstagramType:
        instagram = response.contact ?? '';
        break;

      case TiktokType:
        tiktok = response.contact ?? '';
        break;
    }
  }
}
