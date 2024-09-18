import 'package:coffee_start/core/utils/formatters.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/card/presentation/bloc/local/card/card_local_bloc.dart';
import 'package:coffee_start/features/card/presentation/pages/add_card.dart';
import 'package:coffee_start/features/card/presentation/pages/edit_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsList extends StatelessWidget {
  const CardsList({super.key});

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
        final cards = state.cards;
        return cardsContainer(cards, context);
      }
      return const SizedBox();
    });
  }

  Widget cardsContainer(List<CardEntity> cards, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Open shopping cart',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddCardPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditCardPage(
                            card: card,
                          )),
                );
              },
              leading: const Icon(Icons.credit_card_outlined),
              title: Text(formatCardNumber(card.cardNumber)),
              subtitle: Text('Expires: ${card.month}/${card.year}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(card.name.length > 14
                      ? card.name.substring(0, 11)
                      : card.name),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteConfirmationDialog(card.cardNumber, context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _deleteCard(String cardNumber, BuildContext context) {
    context.read<CardLocalBloc>().add(RemoveCard(cardNumber));
  }

  Future<void> _showDeleteConfirmationDialog(
      String cardNumber, BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Card'),
          content: const Text('Are you sure you want to delete this card?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteCard(cardNumber, context); // Delete the card
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
