import 'package:coffee_start/features/card/domain/entities/card.dart';

abstract class CardRepositoryLocal {
  Future<List<CardEntity>> getCards();
  Future<void> addCard(CardEntity cardEntity);
  Future<void> removeCard(String cardNumber);
  Future<CardEntity> updateCard(CardEntity cardEntity);
}
