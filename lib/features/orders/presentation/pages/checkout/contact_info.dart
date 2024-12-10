import 'package:coffee_start/core/constants/constants.dart';
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
  String? _paymentMethod;

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
            _paymentMethod ??=
                checkoutDataState.checkoutData.paymentInfo.paymentMethod;
            ContactInfoForm.phoneController.text =
                checkoutDataState.checkoutData.contactInfo.phone;
            ContactInfoForm.addressController.text =
                checkoutDataState.checkoutData.contactInfo.address;
            return Form(
              key: widget.formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      widget.checkoutBloc.add(UpdatePhone(value));
                      widget.formKey.currentState!.validate();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone';
                      }
                      return null;
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
                      widget.checkoutBloc.add(UpdateAddress(value));
                      widget.formKey.currentState!.validate();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
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
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  paymentMethods(checkoutDataState),
                  const SizedBox(
                    height: 10,
                  ),
                  if (_paymentMethod == PaymentMethods.card)
                    const Text(
                      "You will be redirected to bank website to fill card details",
                      style: TextStyle(fontSize: 16),
                    )
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
    return Column(
      children: [
        ListTile(
          horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.all(0),
          title: const Row(
            children: [
              Icon(Icons.attach_money_rounded),
              SizedBox(
                width: 6,
              ),
              Text("Cash", style: TextStyle(fontSize: 18)),
            ],
          ),
          leading: Radio(
              value: PaymentMethods.cash,
              groupValue: _paymentMethod,
              onChanged: (String? value) {
                setState(() {
                  _paymentMethod = value;
                  final paymentInfo = PaymentInfo(
                    paymentMethod: PaymentMethods.cash,
                  );
                  widget.checkoutBloc.add(UpdatePaymentInfo(paymentInfo));
                });
              }),
        ),
        ListTile(
          horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.all(0),
          title: const Row(
            children: [
              Icon(Icons.credit_card),
              SizedBox(
                width: 6,
              ),
              Text("Card", style: TextStyle(fontSize: 18)),
            ],
          ),
          leading: Radio(
              value: PaymentMethods.card,
              groupValue: _paymentMethod,
              onChanged: (String? value) {
                setState(() {
                  _paymentMethod = value;
                  final paymentInfo = PaymentInfo(
                    paymentMethod: PaymentMethods.card,
                  );
                  widget.checkoutBloc.add(UpdatePaymentInfo(paymentInfo));
                });
              }),
        ),
      ],
    );
  }
}
