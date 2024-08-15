import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  late final Store store;

  ObjectBox._init(this.store);

  // this instance to be initialized in main
  static ObjectBox? instance;

  static Future<void> init() async {
    await getApplicationDocumentsDirectory().then(
      (value) async {
        final Store store = Store(
          getObjectBoxModel(),
          directory: value.path + '/objectbox',
        );
        instance = ObjectBox._init(store);
      },
    );

    // return ObjectBox._init(store);
  }

  int insetProduct(ProductMapper product) {
    return store.box<ProductMapper>().put(product);
  }

  ProductMapper? getProduct(int id) {
    return store.box<ProductMapper>().get(id);
  }

  List<ProductMapper> getAllProducts() {
    return store.box<ProductMapper>().getAll();
  }

  bool removeProduct(int id) {
    return store.box<ProductMapper>().remove(id);
  }

  bool deleteProduct(int id) {
    return store.box<ProductMapper>().remove(id);
  }

  int deleteAllProducts() {
    return store.box<ProductMapper>().removeAll();
  }

  String displayAllData() {
    final products = store.box<ProductMapper>().getAll();
    final buffer = StringBuffer();
    buffer.writeln();
    buffer.writeln();
    for (final product in products) {
      buffer.writeln(
          "************* ProductDataBaseId: ${product.id2} ProductId: ${product.id} - ProductName: ${product.name} *************");
    }
    buffer.writeln();
    buffer.writeln();
    return buffer.toString();
  }
}
