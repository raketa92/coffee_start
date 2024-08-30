import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/orders/presentation/pages/checkout.dart';
import 'package:coffee_start/features/orders/presentation/pages/contact_info.dart';
import 'package:coffee_start/features/orders/presentation/pages/sms_confirmation.dart';
import 'package:coffee_start/features/orders/presentation/pages/summary.dart';
import 'package:flutter/material.dart';

class CheckoutData {
  String phone = '';
  String address = '';
  CardEntity? card;
  double totalPrice = 0;
}

class CheckoutStepper extends StatefulWidget {
  final int shopId;
  const CheckoutStepper({super.key, required this.shopId});

  @override
  State<CheckoutStepper> createState() => _CheckoutStepperState();
}

class _CheckoutStepperState extends State<CheckoutStepper> {
  int currentStep = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CheckoutData _checkoutData = CheckoutData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Checkout",
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(6),
          child: Stepper(
            key: ValueKey(currentStep),
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepCancel: stepCancel,
            onStepContinue: stepContinue,
            steps: getSteps(),
          ),
        ));
  }

  void stepCancel() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void stepContinue() {
    if (currentStep == 0) {
      setState(() {
        currentStep++;
      });
    } else if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (currentStep < getSteps().length - 1) {
        setState(() {
          currentStep++;
        });
      } else if (_checkoutData.card != null &&
          currentStep < getSteps().length - 1) {
        setState(() {
          currentStep++;
        });
      } else {
        confirmOrder();
      }
    }
  }

  void stepTapped(step) {
    if (step >= 0 && step < getSteps().length) {
      setState(() {
        currentStep = step;
      });
    }
  }

  List<Step> getSteps() {
    List<Step> steps = [
      Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          title: Text(
            currentStep == 0 ? "Checkout" : "",
            overflow: TextOverflow.ellipsis,
          ),
          isActive: currentStep == 0,
          content:
              CheckoutForm(shopId: widget.shopId, checkoutData: _checkoutData)),
      Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          title: Text(
            currentStep == 1 ? "Info" : "",
            overflow: TextOverflow.ellipsis,
          ),
          isActive: currentStep == 1,
          content:
              ContactInfoForm(formKey: _formKey, checkoutData: _checkoutData)),
      Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          title: Text(
            currentStep == 2 ? "Summary" : "",
            overflow: TextOverflow.ellipsis,
          ),
          isActive: currentStep == 2,
          content: SummaryForm(
            checkoutData: _checkoutData,
          )),
    ];

    if (_checkoutData.card != null) {
      steps.add(
        Step(
            state: currentStep > 3 ? StepState.complete : StepState.indexed,
            title: Text(
              currentStep == 3 ? "SMS Code" : "",
              overflow: TextOverflow.ellipsis,
            ),
            isActive: currentStep == 3,
            content: SmsConfirmationForm(
              onConfirmed: confirmOrder,
            )),
      );
    }

    if (currentStep >= steps.length) {
      setState(() {
        currentStep = steps.length - 1;
      });
    }

    return steps;
  }

  void confirmOrder() {
    // Implement the API request here
    print('Order confirmed');
    print('Phone: ${_checkoutData.phone}');
    print('Address: ${_checkoutData.address}');
    print('Payment Method: ${_checkoutData.card != null ? "Card" : "Cash"}');
    if (_checkoutData.card != null) {
      print('Card Details: ${_checkoutData.card}');
    }
    print('Total Price: ${_checkoutData.totalPrice}');
  }
}
