import 'dart:convert';

import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/card/data/models/card.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/card/domain/repository/card_repository_local.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CardRepositoryLocalImpl implements CardRepositoryLocal {
  final HydratedStorage storage;

  CardRepositoryLocalImpl({required this.storage});

  @override
  Future<void> addCard(CardEntity cardEntity) async {
    final cards = await getCards();
    cards.add(CardModel.fromEntity(cardEntity));

    await saveCards(cards);
  }

  @override
  Future<List<CardEntity>> getCards() async {
    final jsonString = storage.read(cardsLocalStorageKey);
    if (jsonString != null) {
      try {
        final List<dynamic> decodedJson = json.decode(jsonString) as List;
        return decodedJson
            .map((item) => CardModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } catch (e) {
        print("Error decoding cart items: $e");
        return [];
      }
    }
    final mockCards = [
      const CardEntity(
          cardNumber: "1234123412341234",
          name: "Mr Test",
          month: 8,
          year: 2028,
          cvv: 123),
      const CardEntity(
          cardNumber: "9876987698769876",
          name: "Mr Test2",
          month: 11,
          year: 2032,
          cvv: 345),
      const CardEntity(
          cardNumber: "9876987698769867",
          name: "Mr Test2",
          month: 12,
          year: 2032,
          cvv: 987)
    ];
    return mockCards;
  }

  @override
  Future<void> removeCard(CardEntity cardEntity) async {
    final cards = await getCards();
    cards.removeWhere((element) => element.cardNumber == cardEntity.cardNumber);

    await saveCards(cards);
  }

  @override
  Future<CardEntity> updateCard(CardEntity cardEntity) async {
    final cards = await getCards();
    cards.removeWhere((element) => element.cardNumber == cardEntity.cardNumber);
    cards.add(CardModel.fromEntity(cardEntity));
    await saveCards(cards);
    return cardEntity;
  }

  Future<void> saveCards(List<CardEntity> cards) async {
    final List<Map<String, dynamic>> cardsJson =
        cards.map((item) => CardModel.fromEntity(item).toJson()).toList();
    final jsonString = json.encode(cardsJson);
    await storage.write(cardsLocalStorageKey, jsonString);
  }
}
