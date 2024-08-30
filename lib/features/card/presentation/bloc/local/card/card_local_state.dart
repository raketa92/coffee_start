part of 'card_local_bloc.dart';

sealed class CardLocalState extends Equatable {
  const CardLocalState();

  @override
  List<Object> get props => [];
}

final class CardLocalInitial extends CardLocalState {}

final class CardsLocalLoading extends CardLocalState {}

final class CardsLocalLoaded extends CardLocalState {
  final List<CardEntity> cards;
  const CardsLocalLoaded({required this.cards});

  CardsLocalLoaded copyWith({required List<CardEntity> cards}) =>
      CardsLocalLoaded(cards: cards);

  @override
  List<Object> get props => [cards];
}

final class CardLocalLoaded extends CardLocalState {
  final CardEntity card;
  const CardLocalLoaded({required this.card});

  CardLocalLoaded copyWith({required CardEntity card}) =>
      CardLocalLoaded(card: card);

  @override
  List<Object> get props => [card];
}

class CardsLocalError extends CardLocalState {
  final String message;
  const CardsLocalError({required this.message});

  @override
  List<Object> get props => [message];
}
