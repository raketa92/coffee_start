import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/core/widgets/card_dropdown.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:coffee_start/features/orders/presentation/bloc/remote/checkout/local_checkout_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactInfoForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final LocalCheckoutBloc checkoutBloc;
  const ContactInfoForm(
      {super.key, required this.formKey, required this.checkoutBloc});
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
    return BlocProvider.value(
      value: widget.checkoutBloc,
      child: BlocBuilder<LocalCheckoutBloc, LocalCheckoutState>(
        builder: (context, checkoutDataState) {
          if (checkoutDataState is LocalCheckoutLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (checkoutDataState is LocalCheckoutError) {
            return const Center(child: Icon(Icons.refresh));
          }

          if (checkoutDataState is LocalCheckoutLoaded) {
            return Form(
              key: widget.formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      // final updatedData = checkoutDataState.checkoutData;
                      // updatedData.phone = value;
                      widget.checkoutBloc.add(UpdatePhone(value));
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
                            borderSide: const BorderSide(
                                width: 1, color: Colors.blue))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      // final updatedData = checkoutDataState.checkoutData;
                      // updatedData.address = value;
                      widget.checkoutBloc.add(UpdateAddress(value));
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
                            borderSide: const BorderSide(
                                width: 1, color: Colors.blue))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  paymentMethods(checkoutDataState),
                  const SizedBox(
                    height: 10,
                  ),
                  if (_paymentMethod == PaymentMethods.card)
                    cardOptions(checkoutDataState),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget paymentMethods(LocalCheckoutLoaded checkoutDataState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _paymentMethod = PaymentMethods.cash;
              // final updatedData = checkoutDataState.checkoutData;
              // updatedData.card = null;
              final paymentInfo =
                  PaymentInfo(paymentMethod: PaymentMethods.cash, card: null);
              widget.checkoutBloc.add(UpdatePaymentInfo(paymentInfo));
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

  Widget cardOptions(LocalCheckoutLoaded checkoutDataState) {
    return FormField<CardEntity>(validator: (value) {
      if (_paymentMethod == PaymentMethods.card &&
          checkoutDataState.checkoutData.paymentInfo.card == null) {
        return 'Please select a card';
      }
      return null;
    }, builder: (FormFieldState<CardEntity> state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardsDropdownButton(
              card: checkoutDataState.checkoutData.paymentInfo.card,
              onCardSelected: (CardEntity card) {
                setState(() {
                  // final updatedData = checkoutDataState.checkoutData;
                  // updatedData.card = card;
                  final paymentInfo = PaymentInfo(
                      paymentMethod: PaymentMethods.card, card: card);
                  widget.checkoutBloc.add(UpdatePaymentInfo(paymentInfo));
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
