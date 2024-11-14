import 'package:coffee_start/features/card/domain/entities/card.dart';

class CardModel extends CardEntity {
  const CardModel(
      {required super.cardNumber,
      required super.year,
      required super.month,
      required super.name,
      required super.cvv,
      required super.cardProvider});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
        cardNumber: json['cardNumber'],
        year: json['year'],
        month: json['month'],
        name: json['name'],
        cvv: json['cvv'],
        cardProvider: json['cardProvider']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'year': year,
      'month': month,
      'name': name,
      'cvv': cvv,
      'cardProvider': cardProvider,
    };
  }

  static CardModel fromEntity(CardEntity entity) {
    return CardModel(
        cardNumber: entity.cardNumber,
        year: entity.year,
        month: entity.month,
        name: entity.name,
        cvv: entity.cvv,
        cardProvider: entity.cardProvider);
  }

  CardEntity toEntity() {
    return CardEntity(
        cardNumber: cardNumber,
        year: year,
        month: month,
        name: name,
        cvv: cvv,
        cardProvider: cardProvider);
  }
}
