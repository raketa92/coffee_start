// not used, we don't store card data in app
  // Widget cardOptions(LocalCheckoutLoaded checkoutDataState) {
  //   return FormField<CardEntity>(validator: (value) {
  //     if (_paymentMethod == PaymentMethods.card &&
  //         checkoutDataState.checkoutData.paymentInfo.card == null) {
  //       return 'Please select a card';
  //     }
  //     return null;
  //   }, builder: (FormFieldState<CardEntity> state) {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         CardsDropdownButton(
  //             card: checkoutDataState.checkoutData.paymentInfo.card,
  //             onCardSelected: (CardEntity card) {
  //               setState(() {
  //                 // final updatedData = checkoutDataState.checkoutData;
  //                 // updatedData.card = card;
  //                 final paymentInfo = PaymentInfo(
  //                     paymentMethod: PaymentMethods.card, card: card);
  //                 widget.checkoutBloc.add(UpdatePaymentInfo(paymentInfo));
  //               });
  //               widget.formKey.currentState!.validate();
  //             }),
  //         if (state.hasError)
  //           Text(
  //             state.errorText ?? '',
  //             style: const TextStyle(color: Colors.red),
  //           )
  //       ],
  //     );
  //   });
  // }