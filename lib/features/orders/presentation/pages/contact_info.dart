import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/core/widgets/card_dropdown.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactInfoForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final CheckoutData checkoutData;
  const ContactInfoForm(
      {super.key, required this.formKey, required this.checkoutData});
  static var phoneController = TextEditingController();
  static var addressController = TextEditingController();
  static var paymentMethodController = TextEditingController();

  @override
  State<ContactInfoForm> createState() => _ContactInfoFormState();
}

class _ContactInfoFormState extends State<ContactInfoForm> {
  String _paymentMethod = PaymentMethods.cash;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              widget.checkoutData.phone = value;
              widget.formKey.currentState!.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter phone';
              }
            },
            controller: ContactInfoForm.phoneController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
                label: const Text('Phone'),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.blue))),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (value) {
              widget.checkoutData.address = value;
              widget.formKey.currentState!.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter address';
              }
            },
            controller: ContactInfoForm.addressController,
            decoration: InputDecoration(
                label: const Text('Address'),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.blue))),
          ),
          const SizedBox(
            height: 10,
          ),
          paymentMethods(),
          const SizedBox(
            height: 10,
          ),
          if (_paymentMethod == PaymentMethods.card) cardOptions(),
        ],
      ),
    );
  }

  Widget paymentMethods() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _paymentMethod = PaymentMethods.cash;
              widget.checkoutData.card = null;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(color: Colors.black)),
            child: const Text("Cash"),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _paymentMethod = PaymentMethods.card;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(color: Colors.black)),
            child: const Text("Card"),
          ),
        ),
      ],
    );
  }

  Widget cardOptions() {
    return FormField<CardEntity>(validator: (value) {
      if (_paymentMethod == PaymentMethods.card &&
          widget.checkoutData.card == null) {
        return 'Please select a card';
      }
      return null;
    }, builder: (FormFieldState<CardEntity> state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardsDropdownButton(
              card: widget.checkoutData.card,
              onCardSelected: (CardEntity card) {
                setState(() {
                  widget.checkoutData.card = card;
                });
                widget.formKey.currentState!.validate();
              }),
          if (state.hasError)
            Text(
              state.errorText ?? '',
              style: const TextStyle(color: Colors.red),
            )
        ],
      );
    });
  }
}
