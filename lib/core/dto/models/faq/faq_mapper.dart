
import 'faq_response.dart';

class FaqMapper{
  late final int id;
  late final String question;
  late final String answer;

  FaqMapper(FaqResponse response){
    id = response.id?? 0;
    question = response.question??'';
    answer = response.answer??'';
  }
}