import 'package:coffee_start/core/utils/formatters.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/card/presentation/bloc/local/card/card_local_bloc.dart';
import 'package:coffee_start/features/orders/presentation/pages/checkout/order_complete.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  String _cardNumber = '**** **** **** ****';
  String _month = 'MM';
  String _year = 'YY';
  String _cardHolderName = 'CARD HOLDER';

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(() {
      setState(() {
        _cardNumber = _cardNumberController.text.isEmpty
            ? '**** **** **** ****'
            : _formatCardNumber(_cardNumber.replaceAll(' ', ''));
      });
    });

    _monthController.addListener(() {
      setState(() {
        _month = _monthController.text.isEmpty ? 'MM' : _monthController.text;
      });
    });

    _yearController.addListener(() {
      setState(() {
        _year = _yearController.text.isEmpty ? 'YY' : _yearController.text;
      });
    });

    _firstNameController.addListener(() {
      setState(() {
        _updateCardHolderName();
      });
    });

    _lastNameController.addListener(() {
      setState(() {
        _updateCardHolderName();
      });
    });
  }

  void _updateCardHolderName() {
    final firstName =
        _firstNameController.text.isEmpty ? '' : _firstNameController.text;
    final lastName =
        _lastNameController.text.isEmpty ? '' : _lastNameController.text;

    _cardHolderName = '$firstName $lastName'.trim().isEmpty
        ? 'CARD HOLDER'
        : '$firstName $lastName';
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
              _buildSubmitButton(),
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
            _cardNumber,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          Text(
            'Expiry: $_month/$_year',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            _cardHolderName,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          card = CardEntity(
              cardNumber: _cardNumberController.text.replaceAll(' ', ''),
              month: int.parse(_month),
              name: _cardHolderName,
              year: int.parse(_year),
              cvv: 000);
          sl<CardLocalBloc>().add(AddCard(card));
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
