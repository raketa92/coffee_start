class CartProductDto {
  final int quantity;
  final String productGuid;

  CartProductDto({required this.quantity, required this.productGuid});

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'productGuid': productGuid,
    };
  }
}

class CreateOrderDto {
  String? userGuid;
  String shopGuid;
  String phone;
  String address;
  String paymentMethod;
  double totalPrice;
  List<CartProductDto> orderItems;

  CreateOrderDto({
    this.userGuid,
    required this.shopGuid,
    required this.phone,
    required this.address,
    required this.paymentMethod,
    required this.totalPrice,
    required this.orderItems,
  });

  Map<String, dynamic> toJson() {
    return {
      'userGuid': userGuid,
      'shopGuid': shopGuid,
      'phone': phone,
      'address': address,
      'paymentMethod': paymentMethod,
      'totalPrice': totalPrice,
      'orderItems': orderItems.map((item) => item.toJson()).toList()
    };
  }
}

class CreateOrderResponseDto {
  String orderNumber;
  String status;
  double totalPrice;
  String? formUrl;

  CreateOrderResponseDto(
      {required this.orderNumber,
      required this.status,
      required this.totalPrice,
      this.formUrl});

  factory CreateOrderResponseDto.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponseDto(
        orderNumber: json['orderNumber'],
        status: json['status'],
        totalPrice: json['totalPrice'] is String
            ? double.parse(json['totalPrice'])
            : json['totalPrice'].toDouble(),
        formUrl: json['formUrl'] ?? '');
  }
}
