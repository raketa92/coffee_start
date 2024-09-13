import 'package:coffee_start/features/card/domain/entities/card.dart';

class CheckoutData {
  String phone = '';
  String address = '';
  CardEntity? card;
  String? smsCode;
  double totalPrice = 0;

  CheckoutData(
      {required this.phone,
      required this.address,
      this.card,
      this.smsCode,
      required this.totalPrice});

  factory CheckoutData.fromJson(Map<String, dynamic> json) {
    return CheckoutData(
        phone: json['phone'],
        address: json['address'],
        totalPrice: json['totalPrice'],
        smsCode: json['smsCode'],
        card: CardEntity.fromJson(json['card']));
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'address': address,
      'totalPrice': totalPrice,
      'smsCode': smsCode,
      'card': card,
    };
  }
}
