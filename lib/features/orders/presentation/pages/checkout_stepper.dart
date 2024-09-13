import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:coffee_start/features/orders/presentation/bloc/remote/orders/remote_orders_bloc.dart';
import 'package:coffee_start/features/orders/presentation/pages/checkout.dart';
import 'package:coffee_start/features/orders/presentation/pages/contact_info.dart';
import 'package:coffee_start/features/orders/presentation/pages/order_complete.dart';
import 'package:coffee_start/features/orders/presentation/pages/sms_confirmation.dart';
import 'package:coffee_start/features/orders/presentation/pages/summary.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutStepper extends StatefulWidget {
  final int shopId;
  const CheckoutStepper({super.key, required this.shopId});

  @override
  State<CheckoutStepper> createState() => _CheckoutStepperState();
}

class _CheckoutStepperState extends State<CheckoutStepper> {
  int currentStep = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _smsFormKey = GlobalKey<FormState>();
  final CheckoutData _checkoutData =
      CheckoutData(phone: '', address: '', totalPrice: 0);

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

      if (currentStep == 3 &&
          _checkoutData.card != null &&
          _smsFormKey.currentState != null) {
        if (!_smsFormKey.currentState!.validate()) {
          return;
        }
        if (_smsFormKey.currentState!.validate()) {
          _smsFormKey.currentState!.save();
        }
      }

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
              formKey: _smsFormKey,
              checkoutData: _checkoutData,
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
    print('Order confirmed');
    print('Phone: ${_checkoutData.phone}');
    print('Address: ${_checkoutData.address}');
    print('Payment Method: ${_checkoutData.card != null ? "Card" : "Cash"}');
    if (_checkoutData.card != null) {
      print('Card Details: ${_checkoutData.card}');
    }
    print('Total Price: ${_checkoutData.totalPrice}');

    final orderBloc = sl<RemoteOrdersBloc>()..add(CreateOrder(_checkoutData));
    orderBloc.stream.listen((state) {
      if (state is OrderCreated) {
        _formKey.currentState?.reset();
        _smsFormKey.currentState?.reset();
        ContactInfoForm.addressController.clear();
        ContactInfoForm.phoneController.clear();
        SmsConfirmationForm.smsCodeController.clear();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                      value: orderBloc,
                      child: const OrderCompletePage(),
                    )));
      } else if (state is RemoteOrdersError) {
        SnackBar(
          content: Text("Order creation failed: ${state.error}"),
        );
      }
    });
  }
}
