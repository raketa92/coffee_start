import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/orders/presentation/bloc/remote/checkout/local_checkout_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryForm extends StatelessWidget {
  final LocalCheckoutBloc checkoutBloc;
  const SummaryForm({super.key, required this.checkoutBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: checkoutBloc,
      child: BlocBuilder<LocalCheckoutBloc, LocalCheckoutState>(
        builder: (context, checkoutDataState) {
          if (checkoutDataState is LocalCheckoutLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (checkoutDataState is LocalCheckoutError) {
            return const Center(child: Icon(Icons.refresh));
          }
          if (checkoutDataState is LocalCheckoutLoaded) {
            final checkoutData = checkoutDataState.checkoutData;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Summary",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  orderDetailRow("Phone:", checkoutData.contactInfo.phone),
                  const SizedBox(height: 5),
                  orderDetailRow("Address:", checkoutData.contactInfo.address),
                  const SizedBox(height: 5),
                  orderDetailRow(
                    "Payment Method:",
                    checkoutData.paymentInfo.paymentMethod ==
                            PaymentMethods.card
                        ? "Card"
                        : "Cash",
                  ),
                  const SizedBox(height: 20),
                  orderDetailRow("Total Price:",
                      "${checkoutData.orderItemsInfo.totalPrice.toStringAsFixed(2)} TMT"),
                ]);
          }
          return Container();
        },
      ),
    );
  }

  Widget orderDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  String formatCardDetails(CardEntity card) {
    return "${card.name} (${card.cardNumber.substring(card.cardNumber.length - 4)})";
  }
}
