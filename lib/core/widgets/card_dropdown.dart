import 'package:coffee_start/core/utils/formatters.dart';
import 'package:coffee_start/core/widgets/button.dart';
import 'package:coffee_start/core/widgets/menu.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardsDropdownButton extends StatefulWidget {
  final CardEntity? card;
  final Function(CardEntity) onCardSelected;
  const CardsDropdownButton(
      {super.key, this.card, required this.onCardSelected});

  @override
  State<CardsDropdownButton> createState() => _CardsDropdownButtonState();
}

class _CardsDropdownButtonState extends State<CardsDropdownButton> {
  final OverlayPortalController _overlayPortalController =
      OverlayPortalController();

  final _link = LayerLink();

  double? _buttonWidth;

  @override
  Widget build(BuildContext context) {
    return dropdownContainer();
  }

  CompositedTransformTarget dropdownContainer() {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _overlayPortalController,
        overlayChildBuilder: (BuildContext context) {
          return CompositedTransformFollower(
            link: _link,
            targetAnchor: Alignment.bottomLeft,
            child: Align(
                alignment: AlignmentDirectional.topStart,
                child: MenuWidget(
                    width: _buttonWidth,
                    onCardSelected: widget.onCardSelected,
                    toggleDropdown: toggleDropdown)),
          );
        },
        child: ButtonWidget(
          onTap: onTap,
          child: Text(widget.card != null
              ? formatCardNumber(widget.card!.cardNumber)
              : 'Select Card'),
        ),
      ),
    );
  }

  void onTap() {
    _buttonWidth = context.size?.width;
    toggleDropdown();
  }

  void toggleDropdown() {
    _overlayPortalController.toggle();
  }
}
