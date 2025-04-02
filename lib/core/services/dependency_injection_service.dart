import 'package:deel/deel.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class DependencyInjectionService {
   static ProductCategoryBloc? _productCategoryBloc;

  dynamic init() async {
    getIt.registerSingleton<AuthenticationSharedBloc>(AuthenticationSharedBloc());
    getIt.registerSingleton<ForgotPasswordBloc>(ForgotPasswordBloc());
    getIt.registerSingleton<MyOrdersBloc>(MyOrdersBloc());
    _productCategoryBloc = getIt.registerSingleton<ProductCategoryBloc>(ProductCategoryBloc());
    getIt.registerSingleton<CartBloc>(CartBloc());
    getIt.registerSingleton<UsagePolicyBloc>(UsagePolicyBloc());
    getIt.registerSingleton<ContactUsBloc>(ContactUsBloc());
    getIt.registerSingleton<MoreBloc>(MoreBloc());
    getIt.registerSingleton<UpdateProfileBloc>(UpdateProfileBloc());


    getIt.registerSingleton<HomeBloc>(HomeBloc(
      onCategoryClick: (categoryMapper) {
        LoggerModule.log(message: '${categoryMapper.id}', name: 'category id');
        _productCategoryBloc!.reset();
        _productCategoryBloc!.categoryId == categoryMapper.id;
      },
      doSearch: (value) {
        if (value.isNotEmpty) {
          _productCategoryBloc!.isForFavourite = false;
          _productCategoryBloc!.reset();
          CustomNavigatorModule.navigatorKey.currentState
              ?.pushNamed(AppScreenEnum.product.name);
          _productCategoryBloc!.doSearch(value);
        }
      },
    ));



  }

}