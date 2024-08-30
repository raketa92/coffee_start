import 'package:coffee_start/core/utils/formatters.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/card/presentation/bloc/local/card/card_local_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsList extends StatelessWidget {
  CardsList(
      {super.key,
      required this.showDeleteIcon,
      required this.onCardSelected,
      required this.toggleDropdown});
  final bool showDeleteIcon;
  final Function(CardEntity) onCardSelected;
  void Function() toggleDropdown;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardLocalBloc, CardLocalState>(
        builder: (context, state) {
      if (state is CardsLocalLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (state is CardsLocalError) {
        return const Center(
          child: Icon(Icons.refresh),
        );
      }
      if (state is CardsLocalLoaded) {
        return cardsContainer(state);
      }
      return const SizedBox();
    });
  }

  Widget cardsContainer(CardsLocalLoaded state) {
    final cards = state.cards;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(fit: FlexFit.loose, child: _cardsList(cards)),
          ElevatedButton(onPressed: () {}, child: const Text('Add Card'))
        ],
      ),
    );
  }

  Widget _cardsList(List<CardEntity> cards) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 6,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        final name = card.name;
        final cardNumber = card.cardNumber;
        final month = card.month;
        final year = card.year;
        return GestureDetector(
          onTap: () {
            onCardSelected(card);
            toggleDropdown();
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _cardNumberAndName(name, cardNumber),
                  Text(formatCardDate(month, year)),
                  if (showDeleteIcon) const Icon(Icons.delete),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _cardNumberAndName(String name, String cardNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(formatCardNumber(cardNumber)), Text(name)],
    );
  }
}
