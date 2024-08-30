import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/orders/presentation/pages/checkout_stepper.dart';
import 'package:flutter/material.dart';

class SummaryForm extends StatelessWidget {
  final CheckoutData checkoutData;
  const SummaryForm({super.key, required this.checkoutData});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Order Summary",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      orderDetailRow("Phone:", checkoutData.phone),
      const SizedBox(height: 5),
      orderDetailRow("Address:", checkoutData.address),
      const SizedBox(height: 5),
      orderDetailRow(
        "Payment Method:",
        checkoutData.card != null ? "Card" : "Cash",
      ),
      if (checkoutData.card != null) ...[
        const SizedBox(height: 5),
        orderDetailRow("Card:", formatCardDetails(checkoutData.card!)),
      ],
      const SizedBox(height: 20),
      orderDetailRow(
          "Total Price:", "${checkoutData.totalPrice.toStringAsFixed(2)} TMT"),
    ]);
  }

  Widget orderDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  String formatCardDetails(CardEntity card) {
    return "${card.name} (${card.cardNumber.substring(card.cardNumber.length - 4)})";
  }
}
