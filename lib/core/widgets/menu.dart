import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/card/presentation/pages/cards_list.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  MenuWidget(
      {super.key,
      this.width,
      required this.onCardSelected,
      required this.toggleDropdown});

  final double? width;
  final Function(CardEntity) onCardSelected;
  void Function() toggleDropdown;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? 200,
        decoration: ShapeDecoration(
          color: Colors.black26,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1.5,
              color: Colors.black26,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: Color.fromARGB(17, 13, 58, 183),
              blurRadius: 32,
              offset: Offset(0, 20),
              spreadRadius: -8,
            ),
          ],
        ),
        child: CardsList(
          showDeleteIcon: false,
          onCardSelected: onCardSelected,
          toggleDropdown: toggleDropdown,
        ));
  }
}
