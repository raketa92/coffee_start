import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/cart/domain/usecases/cart_params.dart';
import 'package:coffee_start/features/cart/presentation/bloc/local/cart_items/cart_items_local_bloc.dart';
import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:coffee_start/features/orders/presentation/bloc/remote/checkout/local_checkout_bloc.dart';
import 'package:coffee_start/features/orders/presentation/bloc/remote/orders/remote_orders_bloc.dart';
import 'package:coffee_start/features/orders/presentation/pages/checkout_state/order_complete.dart';
import 'package:coffee_start/features/orders/presentation/pages/checkout_state/checkout.dart';
import 'package:coffee_start/features/orders/presentation/pages/checkout_state/contact_info.dart';
import 'package:coffee_start/features/orders/presentation/pages/checkout_state/sms_confirmation.dart';
import 'package:coffee_start/features/orders/presentation/pages/checkout_state/summary.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutStepperState extends StatefulWidget {
  final String shopGuid;
  const CheckoutStepperState({super.key, required this.shopGuid});

  @override
  State<CheckoutStepperState> createState() => _CheckoutStepperStateState();
}

class _CheckoutStepperStateState extends State<CheckoutStepperState> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _smsFormKey = GlobalKey<FormState>();
  int stepsCount = 3;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<LocalCheckoutBloc>()..add(LoadCheckoutData(widget.shopGuid)),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Checkout",
            ),
            centerTitle: true,
          ),
          body: BlocListener<RemoteOrdersBloc, RemoteOrdersState>(
            listener: (context, state) {
              final orderBloc = context.read<RemoteOrdersBloc>();
              final checkoutBloc = context.read<LocalCheckoutBloc>();
              if (state is OrderCreated) {
                _resetForms(checkoutBloc);
                _navigateToOrderComplete(context, orderBloc);
                _clearCart(context);
              } else if (state is RemoteOrdersError) {
                _showErrorSnackBar(context, "Order creation failed");
              } else if (state is OrderSmsConfirmed) {
                _smsFormKey.currentState?.reset();
                SmsConfirmationForm.smsCodeController.clear();
                _navigateToOrderComplete(context, orderBloc);
              } else if (state is OrderSmsConfirmError) {
                _showErrorSnackBar(
                    context, "Order confirm failed: ${state.error}");
              }
            },
            child: BlocBuilder<LocalCheckoutBloc, LocalCheckoutState>(
              builder: (context, state) {
                if (state is LocalCheckoutLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                if (state is LocalCheckoutError) {
                  return const Center(child: Icon(Icons.refresh));
                }

                if (state is LocalCheckoutLoaded) {
                  final orderBloc = context.read<RemoteOrdersBloc>();
                  final checkoutBloc = context.read<LocalCheckoutBloc>();
                  final checkoutData = state.checkoutData;
                  final currentStep = state.currentStep;
                  return _buildStepper(currentStep, checkoutBloc, state,
                      checkoutData, orderBloc);
                }
                return Container();
              },
            ),
          )),
    );
  }

  Container _buildStepper(
      int currentStep,
      LocalCheckoutBloc checkoutBloc,
      LocalCheckoutLoaded state,
      CheckoutData checkoutData,
      RemoteOrdersBloc orderBloc) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Stepper(
        key: ValueKey(currentStep),
        type: StepperType.horizontal,
        currentStep: currentStep,
        onStepCancel: () {
          if (currentStep > 0) {
            checkoutBloc.add(UpdateCurrentStep(state.currentStep - 1));
          }
        },
        onStepContinue: () {
          stepContinue(currentStep, checkoutData, checkoutBloc, orderBloc);
        },
        steps: getSteps(currentStep, checkoutData, checkoutBloc),
      ),
    );
  }

  void stepContinue(int currentStep, CheckoutData checkoutData,
      LocalCheckoutBloc checkoutBloc, RemoteOrdersBloc orderBloc) {
    if (currentStep == 0) {
      checkoutBloc.add(UpdateCurrentStep(currentStep + 1));
    } else if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (currentStep == 3 &&
          checkoutData.paymentInfo.card != null &&
          _smsFormKey.currentState != null) {
        if (!_smsFormKey.currentState!.validate()) {
          return;
        }
        if (_smsFormKey.currentState!.validate()) {
          _smsFormKey.currentState!.save();
        }
      }

      if (currentStep < stepsCount - 1) {
        checkoutBloc.add(UpdateCurrentStep(currentStep + 1));
      } else if (checkoutData.paymentInfo.card != null &&
          currentStep < stepsCount - 1) {
        checkoutBloc.add(UpdateCurrentStep(currentStep + 1));
      } else {
        createOrder(checkoutData, orderBloc);
      }
    }
  }

  void createOrder(CheckoutData checkoutData, RemoteOrdersBloc orderBloc) {
    print('Order confirmed');
    orderBloc.add(CreateOrder(checkoutData));
  }

  void confirmSmsOrder(String sms, String orderNumber) {
    final orderBloc = sl<RemoteOrdersBloc>();
    orderBloc.add(ConfirmSmsOrder(sms, orderNumber));
  }

  void _resetForms(LocalCheckoutBloc checkoutBloc) {
    _formKey.currentState?.reset();
    _smsFormKey.currentState?.reset();
    ContactInfoForm.addressController.clear();
    ContactInfoForm.phoneController.clear();
    SmsConfirmationForm.smsCodeController.clear();
    checkoutBloc.add(ClearState(widget.shopGuid));
  }

  void _navigateToOrderComplete(
      BuildContext context, RemoteOrdersBloc orderBloc) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: orderBloc,
          child: const OrderCompletePage(),
        ),
      ),
    );
  }

  void _clearCart(BuildContext context) {
    final localCheckoutState = context.read<LocalCheckoutBloc>().state;

    if (localCheckoutState is LocalCheckoutLoaded) {
      final cartItems =
          localCheckoutState.checkoutData.orderItemsInfo.orderItems;
      final List<CartParams> cartParams = [];
      for (var item in cartItems) {
        final cartParam = CartParams(
          shopGuid: widget.shopGuid,
          product: CartItemProductEntity(
            product: item.product,
          ),
        );
        cartParams.add(cartParam);
      }
      context.read<CartItemsLocalBloc>().add(RemoveFromCart(cartParams));
    } else {
      print("Checkout data is not loaded.");
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  List<Step> getSteps(int currentStep, CheckoutData checkoutData,
      LocalCheckoutBloc checkoutBloc) {
    List<Step> steps = [
      Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          title: Text(
            currentStep == 0 ? "Checkout" : "",
            overflow: TextOverflow.ellipsis,
          ),
          isActive: currentStep == 0,
          content: CheckoutForm(
              shopGuid: widget.shopGuid, checkoutBloc: checkoutBloc)),
      Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          title: Text(
            currentStep == 1 ? "Info" : "",
            overflow: TextOverflow.ellipsis,
          ),
          isActive: currentStep == 1,
          content: ContactInfoForm(
            formKey: _formKey,
            checkoutBloc: checkoutBloc,
          )),
      Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          title: Text(
            currentStep == 2 ? "Summary" : "",
            overflow: TextOverflow.ellipsis,
          ),
          isActive: currentStep == 2,
          content: SummaryForm(
            checkoutBloc: checkoutBloc,
          )),
    ];

    if (checkoutData.paymentInfo.card != null) {
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
              // onConfirmed: confirmSmsOrder,
            )),
      );
      stepsCount++;
    }

    if (currentStep >= stepsCount) {
      checkoutBloc.add(UpdateCurrentStep(currentStep - 1));
    }

    return steps;
  }
}
