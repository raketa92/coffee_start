import 'package:coffee_start/core/utils/formatters.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/card/presentation/bloc/local/card/card_local_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  late CardEntity card;

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(() {
      setState(() {
        _formatCardNumber(_cardNumberController.text);
      });
    });

    _monthController.addListener(() {
      setState(() {});
    });

    _yearController.addListener(() {
      setState(() {});
    });

    _firstNameController.addListener(() {
      setState(() {});
    });

    _lastNameController.addListener(() {
      setState(() {});
    });
  }

  _formatCardNumber(String input) {
    String formatted = input.replaceAllMapped(RegExp(r".{1,4}"), (match) {
      return '${match.group(0)}';
    });
    return formatCardNumber(formatted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildCardNumberField(),
              const SizedBox(height: 10),
              _buildExpiryDateFields(),
              const SizedBox(height: 10),
              _buildNameFields(),
              const SizedBox(height: 20),
              _buildCardPreview(),
              const SizedBox(height: 20),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardNumberField() {
    return TextFormField(
      controller: _cardNumberController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
        CreditCardNumberFormatter()
      ],
      decoration: const InputDecoration(
          counterText: '',
          labelText: 'Card Number',
          border: OutlineInputBorder()),
      validator: (value) {
        if (value == null || value.isEmpty || value.trim().isEmpty) {
          return 'Please enter a card number';
        }
        if (value.length < 16 || value.replaceAll(' ', '').length < 16) {
          return 'Card number must be 16 digits';
        }
        return null;
      },
    );
  }

  Widget _buildExpiryDateFields() {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          controller: _monthController,
          keyboardType: TextInputType.number,
          maxLength: 2,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            labelText: 'MM',
            counterText: '',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'MM required';
            }
            if (int.parse(value) > 12) {
              return 'Invalid month';
            }
            return null;
          },
        )),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: _yearController,
            keyboardType: TextInputType.number,
            maxLength: 2,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'YY',
              counterText: '',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'YY required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNameFields() {
    return Column(
      children: [
        TextFormField(
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'First name required';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Last name required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCardPreview() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Card',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            _cardNumberController.text.isEmpty
                ? '**** **** **** ****'
                : _formatCardNumber(
                    _cardNumberController.text.replaceAll(' ', '')),
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          Text(
            'Expiry: ${_monthController.text.isEmpty ? 'MM' : _monthController.text}/${_yearController.text.isEmpty ? 'YY' : _yearController.text}',
            // 'Expiry: $_month/$_year',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            // _cardHolderName,
            '${_firstNameController.text} ${_lastNameController.text}'
                    .trim()
                    .isEmpty
                ? 'CARD HOLDER'
                : '${_firstNameController.text} ${_lastNameController.text}',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          card = CardEntity(
              cardNumber: _cardNumberController.text.replaceAll(' ', ''),
              month: int.parse(_monthController.text),
              year: int.parse(_yearController.text),
              name: '${_firstNameController.text} ${_lastNameController.text}',
              cvv: 000,
              cardProvider: "VISA");
          context.read<CardLocalBloc>().add(AddCard(card));
          Navigator.pop(
            context,
          );
        }
      },
      child: const Text('Add Card'),
    );
  }
}

class CreditCardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String enteredData = newValue.text;
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < enteredData.length; i++) {
      buffer.write(enteredData[i]);
      int index = i + 1;
      if (index % 4 == 0 && enteredData.length != index) {
        buffer.write(' ');
      }
    }

    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.toString().length));
  }
}
