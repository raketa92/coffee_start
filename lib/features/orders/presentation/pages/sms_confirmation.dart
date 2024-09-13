import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:flutter/material.dart';

class SmsConfirmationForm extends StatefulWidget {
  final VoidCallback onConfirmed;
  final GlobalKey<FormState> formKey;
  final CheckoutData checkoutData;
  const SmsConfirmationForm(
      {super.key,
      required this.onConfirmed,
      required this.checkoutData,
      required this.formKey});

  static var smsCodeController = TextEditingController();

  @override
  State<SmsConfirmationForm> createState() => _SmsConfirmationFormState();
}

class _SmsConfirmationFormState extends State<SmsConfirmationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "SMS Confirmation",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextFormField(
            onChanged: (value) {
              widget.checkoutData.smsCode = value;
              widget.formKey.currentState!.validate();
            },
            controller: SmsConfirmationForm.smsCodeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter sms code';
              }
              return null;
            },
            // onFieldSubmitted: (value) {
            //   widget.formKey.currentState!.validate();
            // },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'SMS Code',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 1, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
