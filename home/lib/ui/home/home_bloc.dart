import 'package:core/core.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/home/offer_mapper.dart';
import 'package:core/dto/models/home/category_mapper.dart';
import 'package:core/dto/models/home/promotion_mapper.dart';
import 'package:core/dto/remote/category_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';

class HomeBloc extends BlocBase {
  final TextFormFiledBloc searchBloc = TextFormFiledBloc();
  final BehaviorSubject<ApiState<List<OfferMapper>>> _offersBehaviour =
      BehaviorSubject()..sink.add(LoadingState());
  final BehaviorSubject<ApiState<List<PromotionMapper>>> _promotionBehaviour =
      BehaviorSubject()..sink.add(LoadingState());
  final BehaviorSubject<ApiState<List<CategoryMapper>>> _categoryBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  final Function(CategoryMapper categoryMapper) onCategoryClick;
  final Function(String value) doSearch;

  HomeBloc({required this.onCategoryClick, required this.doSearch});

  Stream<ApiState<List<OfferMapper>>> get offerStream =>
      _offersBehaviour.stream;

  Stream<ApiState<List<PromotionMapper>>> get promotionStream =>
      _promotionBehaviour.stream;

  Stream<ApiState<List<CategoryMapper>>> get categoryStream =>
      _categoryBehaviour.stream;

  void loadData() {
    _loadOffers();
    _loadPromotion();
    _loadCategory();
  }

  void _loadOffers() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      List<OfferMapper> list = [];
      list.add(
        OfferMapper(
            offerDetails:
                'وفرت كل منتجات الألبان والعصاير لازم تبقا موجودة ف محلك ',
            name: 'المراعي',
            image:
                'https://img.freepik.com/free-psd/special-deal-super-offer-upto-60-parcent-off-isolated-3d-render-with-editable-text_47987-15330.jpg?w=996&t=st=1709542076~exp=1709542676~hmac=30332dc7ec46b0180ea0cc70f1a118673d9c94ca3602abee3d9bc1cee5035442',
            id: 1),
      );
      list.add(OfferMapper(
          offerDetails:
              'وفرت كل منتجات الألبان والعصاير لازم تبقا موجودة ف محلك ',
          name: 'المراعي',
          image:
              'https://img.freepik.com/free-psd/special-deal-super-offer-upto-60-parcent-off-isolated-3d-render-with-editable-text_47987-15330.jpg?w=996&t=st=1709542076~exp=1709542676~hmac=30332dc7ec46b0180ea0cc70f1a118673d9c94ca3602abee3d9bc1cee5035442',
          id: 2));
      list.add(OfferMapper(
          offerDetails:
              'وفرت كل منتجات الألبان والعصاير لازم تبقا موجودة ف محلك ',
          name: 'المراعي',
          image:
              'https://img.freepik.com/free-psd/special-deal-super-offer-upto-60-parcent-off-isolated-3d-render-with-editable-text_47987-15330.jpg?w=996&t=st=1709542076~exp=1709542676~hmac=30332dc7ec46b0180ea0cc70f1a118673d9c94ca3602abee3d9bc1cee5035442',
          id: 3));
      _offersBehaviour.sink.add(SuccessState(list));
    });
  }

  void _loadPromotion() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      List<PromotionMapper> list = [];
      list.add(
        PromotionMapper(
            description: 'لما تشتري من 7 منتجات مختلفة',
            name: 'خصم 0.75% على طلبك',
            image:
                'https://img.freepik.com/free-psd/special-deal-super-offer-upto-60-parcent-off-isolated-3d-render-with-editable-text_47987-15330.jpg?w=996&t=st=1709542076~exp=1709542676~hmac=30332dc7ec46b0180ea0cc70f1a118673d9c94ca3602abee3d9bc1cee5035442',
            id: 1),
      );
      list.add(PromotionMapper(
          description: 'لما تشتري من 7 منتجات مختلفة',
          name: 'خصم 0.75% على طلبك',
          image:
              'https://img.freepik.com/free-psd/special-deal-super-offer-upto-60-parcent-off-isolated-3d-render-with-editable-text_47987-15330.jpg?w=996&t=st=1709542076~exp=1709542676~hmac=30332dc7ec46b0180ea0cc70f1a118673d9c94ca3602abee3d9bc1cee5035442',
          id: 2));
      list.add(PromotionMapper(
          description: 'لما تشتري من 7 منتجات مختلفة',
          name: 'خصم 0.75% على طلبك',
          image:
              'https://img.freepik.com/free-psd/special-deal-super-offer-upto-60-parcent-off-isolated-3d-render-with-editable-text_47987-15330.jpg?w=996&t=st=1709542076~exp=1709542676~hmac=30332dc7ec46b0180ea0cc70f1a118673d9c94ca3602abee3d9bc1cee5035442',
          id: 3));
      _promotionBehaviour.sink.add(SuccessState(list));
    });
  }

  void _loadCategory() {
    CategoryRemote().callApiAsStream().listen((event) {
      _categoryBehaviour.sink.add(event);
    });
  }

  @override
  void dispose() {
    // searchBloc.dispose();
    // _offersBehaviour.close();
    // _categoryBehaviour.close();
    // _promotionBehaviour.close();
  }
}
