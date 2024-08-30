import 'package:flutter/material.dart';

class SmsConfirmationForm extends StatefulWidget {
  final VoidCallback onConfirmed;
  const SmsConfirmationForm({super.key, required this.onConfirmed});

  @override
  State<SmsConfirmationForm> createState() => _SmsConfirmationFormState();
}

class _SmsConfirmationFormState extends State<SmsConfirmationForm> {
  final TextEditingController _smsCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "SMS Confirmation",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _smsCodeController,
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
    );
  }
}
