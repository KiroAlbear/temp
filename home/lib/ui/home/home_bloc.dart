import 'package:core/core.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/home/category_mapper.dart';
import 'package:core/dto/models/home/offer_mapper.dart';
import 'package:core/dto/remote/category_remote.dart';
import 'package:core/dto/remote/hero_banner_remote.dart';
import 'package:core/dto/remote/offer_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';

class HomeBloc extends BlocBase {
  final TextFormFiledBloc searchBloc = TextFormFiledBloc();
  final BehaviorSubject<ApiState<List<OfferMapper>>> _heroBannersBehaviour =
      BehaviorSubject()..sink.add(LoadingState());
  final BehaviorSubject<ApiState<List<OfferMapper>>> _offersBehaviour =
      BehaviorSubject()..sink.add(LoadingState());
  final BehaviorSubject<ApiState<List<CategoryMapper>>> _categoryBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  final Function(CategoryMapper categoryMapper) onCategoryClick;
  final Function(String value) doSearch;

  HomeBloc({required this.onCategoryClick, required this.doSearch});

  Stream<ApiState<List<OfferMapper>>> get heroBannersStream =>
      _heroBannersBehaviour.stream;

  Stream<ApiState<List<OfferMapper>>> get offersStream =>
      _offersBehaviour.stream;

  Stream<ApiState<List<CategoryMapper>>> get categoryStream =>
      _categoryBehaviour.stream;

  OfferMapper? selectedOffer;

  void loadData() {
    _loadOffers();
    _loadHeroBanners();
    _loadCategory();
  }

  void _loadOffers() {
    OfferRemote().callApiAsStream().listen(
      (event) {
        _offersBehaviour.sink.add(event);
      },
    );
  }

  void _loadHeroBanners() {
    HeroBannerRemote().callApiAsStream().listen(
      (event) {
        _heroBannersBehaviour.sink.add(event);
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
