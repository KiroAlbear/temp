import 'package:deel/deel.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class DependencyInjectionService {
  static ProductCategoryBloc? _productCategoryBloc;

  dynamic init() async {
    getIt.registerSingleton<AuthenticationSharedBloc>(
        AuthenticationSharedBloc());
    getIt.registerSingleton<ForgotPasswordBloc>(ForgotPasswordBloc());
    getIt.registerSingleton<MyOrdersBloc>(MyOrdersBloc());
    _productCategoryBloc =
        getIt.registerSingleton<ProductCategoryBloc>(ProductCategoryBloc());
    getIt.registerSingleton<CartBloc>(CartBloc());
    getIt.registerSingleton<UsagePolicyBloc>(UsagePolicyBloc());
    getIt.registerSingleton<ContactUsBloc>(ContactUsBloc());
    getIt.registerSingleton<MoreBloc>(MoreBloc());
    getIt.registerSingleton<UpdateProfileBloc>(UpdateProfileBloc());
    getIt.registerSingleton<BottomNavigationBloc>(BottomNavigationBloc());
    getIt.registerSingleton<NewAccountBloc>(NewAccountBloc());

    getIt.registerSingleton<HomeBloc>(HomeBloc(
      onCategoryClick: (categoryMapper) {
        LoggerModule.log(message: '${categoryMapper.id}', name: 'category id');
        _productCategoryBloc!.disposeReset();
        _productCategoryBloc!.categoryId == categoryMapper.id;
      },
      doSearch: (value, context) {
        if (value.isNotEmpty) {
          // _productCategoryBloc!.isForFavourite = false;
          _productCategoryBloc!.disposeReset();
          // CustomNavigatorModule.navigatorKey.currentState
          //     ?.pushNamed(AppScreenEnum.product.name, arguments: {ProductListWidget.isForFavouriteKey: false});
          _productCategoryBloc!.doSearch(value);
          Routes.navigateToScreen(
              Routes.productCategoryPage, NavigationType.goNamed, context);
        }
      },
    ));
  }
}
