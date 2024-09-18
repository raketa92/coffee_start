import 'dart:async';

import 'package:coffee_start/features/card/data/models/card.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/card/domain/usecases/add_card.dart';
import 'package:coffee_start/features/card/domain/usecases/get_cards.dart';
import 'package:coffee_start/features/card/domain/usecases/remove_card.dart';
import 'package:coffee_start/features/card/domain/usecases/update_card.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'card_local_event.dart';
part 'card_local_state.dart';

class CardLocalBloc extends Bloc<CardLocalEvent, CardLocalState>
    with HydratedMixin {
  final GetCardsUseCase _getCardsUseCase;
  final AddCardUseCase _addCardUseCase;
  final RemoveCardUseCase _removeCardUseCase;
  final UpdateCardUseCase _updateCardUseCase;
  CardLocalBloc(this._addCardUseCase, this._getCardsUseCase,
      this._removeCardUseCase, this._updateCardUseCase)
      : super(CardLocalInitial()) {
    on<GetCards>(onGetCards);
    on<AddCard>(onAddCard);
    on<RemoveCard>(onRemoveCard);
    on<UpdateCard>(onUpdateCard);
  }

  @override
  CardLocalState? fromJson(Map<String, dynamic> json) {
    try {
      final cards = (json['cards'] as List)
          .map((item) => CardModel.fromJson(item))
          .toList();
      return CardsLocalLoaded(cards: cards);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(CardLocalState state) {
    if (state is CardsLocalLoaded) {
      return {
        'cards':
            state.cards.map((e) => CardModel.fromEntity(e).toJson()).toList()
      };
    }
    return null;
  }

  FutureOr<void> onGetCards(
      GetCards event, Emitter<CardLocalState> emit) async {
    emit(CardsLocalLoading());
    try {
      final data = await _getCardsUseCase();
      if (data.isNotEmpty) {
        emit(CardsLocalLoaded(cards: data));
      } else {
        emit(const CardsLocalLoaded(cards: []));
      }
    } catch (e) {
      emit(CardsLocalError(message: e.toString()));
    }
  }

  FutureOr<void> onAddCard(AddCard event, Emitter<CardLocalState> emit) async {
    emit(CardsLocalLoading());
    await _addCardUseCase(params: event.card);
    final updatedCards = await _getCardsUseCase();
    emit(CardsLocalLoaded(cards: updatedCards));
  }

  FutureOr<void> onRemoveCard(
      RemoveCard event, Emitter<CardLocalState> emit) async {
    if (state is CardsLocalLoaded) {
      final currentState = state as CardsLocalLoaded;
      await _removeCardUseCase(params: event.cardNumber);
      final updatedCards = await _getCardsUseCase();
      emit(currentState.copyWith(cards: updatedCards));
    }
  }

  FutureOr<void> onUpdateCard(
      UpdateCard event, Emitter<CardLocalState> emit) async {
    if (state is CardsLocalLoaded) {
      final currentState = state as CardsLocalLoaded;
      await _updateCardUseCase(params: event.card);
      final updatedCards = await _getCardsUseCase();
      emit(currentState.copyWith(cards: updatedCards));
    }
  }
}
