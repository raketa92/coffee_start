part of 'local_checkout_bloc.dart';

sealed class LocalCheckoutState extends Equatable {
  const LocalCheckoutState();

  @override
  List<Object> get props => [];
}

final class LocalCheckoutInitial extends LocalCheckoutState {
  final int currentStep;
  const LocalCheckoutInitial({required this.currentStep});
}

final class LocalCheckoutLoading extends LocalCheckoutState {}

final class LocalCheckoutLoaded extends LocalCheckoutState {
  final CheckoutData checkoutData;
  final int currentStep;
  const LocalCheckoutLoaded(
      {required this.checkoutData, required this.currentStep});

  LocalCheckoutLoaded copyWith(
          {CheckoutData? checkoutData, int? currentStep}) =>
      LocalCheckoutLoaded(
          checkoutData: checkoutData ?? this.checkoutData,
          currentStep: currentStep ?? this.currentStep);

  @override
  List<Object> get props => [checkoutData, currentStep];
}

final class LocalCheckoutContactInfoLoaded extends LocalCheckoutState {
  final ContactInfo contactInfo;
  const LocalCheckoutContactInfoLoaded({required this.contactInfo});

  LocalCheckoutContactInfoLoaded copyWith({required ContactInfo contactInfo}) =>
      LocalCheckoutContactInfoLoaded(contactInfo: contactInfo);

  @override
  List<Object> get props => [contactInfo];
}

final class LocalCheckoutPaymentInfoLoaded extends LocalCheckoutState {
  final PaymentInfo paymentInfo;
  const LocalCheckoutPaymentInfoLoaded({required this.paymentInfo});

  LocalCheckoutPaymentInfoLoaded copyWith({required PaymentInfo paymentInfo}) =>
      LocalCheckoutPaymentInfoLoaded(paymentInfo: paymentInfo);

  @override
  List<Object> get props => [paymentInfo];
}

final class LocalCheckoutOrderItemsInfoLoaded extends LocalCheckoutState {
  final OrderItemsInfo orderItemsInfo;
  const LocalCheckoutOrderItemsInfoLoaded({required this.orderItemsInfo});

  LocalCheckoutOrderItemsInfoLoaded copyWith(
          {required OrderItemsInfo orderItemsInfo}) =>
      LocalCheckoutOrderItemsInfoLoaded(orderItemsInfo: orderItemsInfo);

  @override
  List<Object> get props => [orderItemsInfo];
}

class LocalCheckoutError extends LocalCheckoutState {
  final String message;
  const LocalCheckoutError({required this.message});

  @override
  List<Object> get props => [message];
}
