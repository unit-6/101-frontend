class Product {
  final int? code;
  final String? message;
  List<ProductData>? data;
  final int? total;
  final String? totalProfit;

  Product({this.code, this.message, this.data, this.total, this.totalProfit});

  factory Product.fromJson(Map<String, dynamic> json) {
    var tagObjsJson = json['data'] as List;
    List<ProductData> _productData = tagObjsJson.map((tagJson) => ProductData.fromJson(tagJson)).toList();

    return Product(
      code: json['code'],
      message: json['message'],
      data: _productData,
      total: json['total'],
      totalProfit: json['total_profit']
    );
  }
}

class ProductData {
  final int? id;
  final String? name;
  final String? salesPrice;
  final String? currencyCode;
  final String? currencySymbol;
  final int? stockQty;
  final int? isActive;
  final String? createdAt;
  final String? updatedAt;
  final String? merchantId;

  ProductData({
    this.id, 
    this.name, 
    this.salesPrice, 
    this.currencyCode, 
    this.currencySymbol, 
    this.stockQty, 
    this.isActive, 
    this.createdAt, 
    this.updatedAt, 
    this.merchantId
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      name: json['name'],
      salesPrice: json['salesPrice'],
      currencyCode: json['currencyCode'],
      currencySymbol: json['currencySymbol'],
      stockQty: json['stockQty'],
      isActive: json['isActive'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      merchantId: json['merchant_id']
    );
  }
}