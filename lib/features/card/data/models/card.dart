import 'package:coffee_start/features/card/domain/entities/card.dart';

class CardModel extends CardEntity {
  const CardModel(
      {required super.cardNumber,
      required super.year,
      required super.month,
      required super.name});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
        cardNumber: json['cardNumber'],
        year: json['year'],
        month: json['month'],
        name: json['name']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'year': year,
      'month': month,
      'name': name,
    };
  }

  static CardModel fromEntity(CardEntity entity) {
    return CardModel(
        cardNumber: entity.cardNumber,
        year: entity.year,
        month: entity.month,
        name: entity.name);
  }

  CardEntity toEntity() {
    return CardEntity(
        cardNumber: cardNumber, year: year, month: month, name: name);
  }
}
