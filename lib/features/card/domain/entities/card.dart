import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final String cardNumber;
  final int month;
  final int year;
  final String name;
  final int cvv;

  const CardEntity(
      {required this.cardNumber,
      required this.month,
      required this.name,
      required this.year,
      required this.cvv});

  @override
  List<Object?> get props => [cardNumber, month, year, name];

  factory CardEntity.fromJson(Map<String, dynamic> json) {
    return CardEntity(
        cardNumber: json['cardNumber'],
        month: json['month'],
        year: json['year'],
        name: json['name'],
        cvv: json['cvv']);
  }

  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'month': month,
      'year': year,
      'name': name,
      'cvv': cvv
    };
  }

  CardEntity copyWith({
    String? cardNumber,
    int? month,
    int? year,
    String? name,
    int? cvv,
  }) {
    return CardEntity(
      cardNumber: cardNumber ?? this.cardNumber,
      month: month ?? this.month,
      year: year ?? this.year,
      name: name ?? this.name,
      cvv: cvv ?? this.cvv,
    );
  }
}
