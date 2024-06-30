import 'package:core/core.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/home/offer_mapper.dart';
import 'package:core/dto/models/home/category_mapper.dart';
import 'package:core/dto/remote/category_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:core/dto/remote/offer_remote.dart';
import 'package:core/dto/remote/hero_banner_remote.dart';

class HomeBloc extends BlocBase {
  final TextFormFiledBloc searchBloc = TextFormFiledBloc();
  final BehaviorSubject<ApiState<List<OfferMapper>>> _offersBehaviour =
      BehaviorSubject()..sink.add(LoadingState());
  final BehaviorSubject<ApiState<List<OfferMapper>>> _promotionBehaviour =
      BehaviorSubject()..sink.add(LoadingState());
  final BehaviorSubject<ApiState<List<CategoryMapper>>> _categoryBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  final Function(CategoryMapper categoryMapper) onCategoryClick;
  final Function(String value) doSearch;

  HomeBloc({required this.onCategoryClick, required this.doSearch});

  Stream<ApiState<List<OfferMapper>>> get offerStream =>
      _offersBehaviour.stream;

  Stream<ApiState<List<OfferMapper>>> get promotionStream =>
      _promotionBehaviour.stream;

  Stream<ApiState<List<CategoryMapper>>> get categoryStream =>
      _categoryBehaviour.stream;

  void loadData() {
    _loadOffers();
    _loadPromotion();
    _loadCategory();
  }

  void _loadOffers() {
    OfferRemote().callApiAsStream().listen(
      (event) {
        _offersBehaviour.sink.add(event);
      },
    );
  }

  void _loadPromotion() {
    HeroBannerRemote().callApiAsStream().listen(
      (event) {
        _promotionBehaviour.sink.add(event);
      },
    );
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
