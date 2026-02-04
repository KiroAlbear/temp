import 'package:deel/deel.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  final TextFormFiledBloc searchBloc = TextFormFiledBloc();
  final BehaviorSubject<ApiState<List<OfferMapper>>> _heroBannersBehaviour =
      BehaviorSubject()..sink.add(LoadingState());
  final BehaviorSubject<ApiState<List<OfferMapper>>> _offersBehaviour =
      BehaviorSubject()..sink.add(LoadingState());
  final BehaviorSubject<ApiState<List<CategoryMapper>>> _categoryBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  final Function(CategoryMapper categoryMapper) onCategoryClick;
  final Function(String value, BuildContext context) doSearch;

  HomeBloc({required this.onCategoryClick, required this.doSearch});

  Stream<ApiState<List<OfferMapper>>> get heroBannersStream =>
      _heroBannersBehaviour.stream;

  Stream<ApiState<List<OfferMapper>>> get offersStream =>
      _offersBehaviour.stream;

  Stream<ApiState<List<CategoryMapper>>> get categoryStream =>
      _categoryBehaviour.stream;

  OfferMapper? selectedOffer;
  bool isBanner = false;

  String selectedCategoryText = "";


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

  void reset() {
    isBanner = false;
    selectedOffer = null;
    selectedCategoryText = "";
  }

  @override
  void dispose() {
  }
}
