part of 'card_local_bloc.dart';

sealed class CardLocalEvent extends Equatable {
  const CardLocalEvent();

  @override
  List<Object> get props => [];
}

class GetCards extends CardLocalEvent {
  const GetCards();
}

class GetCardByNumber extends CardLocalEvent {
  final String cardNumber;
  const GetCardByNumber(this.cardNumber);
}

class AddCard extends CardLocalEvent {
  final CardEntity card;
  const AddCard(this.card);
}

class RemoveCard extends CardLocalEvent {
  final String cardNumber;
  const RemoveCard(this.cardNumber);
}

class UpdateCard extends CardLocalEvent {
  final CardEntity card;
  const UpdateCard(this.card);
}
