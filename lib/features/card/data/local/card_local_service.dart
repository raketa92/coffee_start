import 'package:coffee_start/features/card/data/models/card.dart';

abstract class CardLocalService {
  Future<List<CardModel>> getCards();
  Future<void> addCard(CardModel cardModel);
  Future<void> removeCard(CardModel cardModel);
  Future<CardModel> updateCard(CardModel cardModel);
}
