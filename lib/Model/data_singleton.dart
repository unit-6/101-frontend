import 'package:sbit_mobile/Model/product.dart';

class DataSingleton {
  static final DataSingleton _singleton = DataSingleton._internal();
  factory DataSingleton() => _singleton;
  DataSingleton._internal();
  static DataSingleton get shared => _singleton;

  Product? productData;
}