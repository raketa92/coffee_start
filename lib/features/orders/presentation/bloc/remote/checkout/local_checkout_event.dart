part of 'local_checkout_bloc.dart';

sealed class LocalCheckoutEvent extends Equatable {
  const LocalCheckoutEvent();

  @override
  List<Object> get props => [];
}

class UpdateContactInfo extends LocalCheckoutEvent {
  final ContactInfo contactInfo;
  const UpdateContactInfo(this.contactInfo);

  @override
  List<Object> get props => [contactInfo];
}

class UpdatePhone extends LocalCheckoutEvent {
  final String phone;
  const UpdatePhone(this.phone);

  @override
  List<Object> get props => [phone];
}

class UpdateAddress extends LocalCheckoutEvent {
  final String address;
  const UpdateAddress(this.address);

  @override
  List<Object> get props => [address];
}

class UpdatePaymentInfo extends LocalCheckoutEvent {
  final PaymentInfo paymentInfo;
  const UpdatePaymentInfo(this.paymentInfo);

  @override
  List<Object> get props => [paymentInfo];
}

class UpdateOrderItemsInfo extends LocalCheckoutEvent {
  final OrderItemsInfo orderItemsInfo;
  const UpdateOrderItemsInfo(this.orderItemsInfo);

  @override
  List<Object> get props => [orderItemsInfo];
}

class UpdateCurrentStep extends LocalCheckoutEvent {
  final int currentStep;
  const UpdateCurrentStep(this.currentStep);

  @override
  List<Object> get props => [currentStep];
}

class ClearState extends LocalCheckoutEvent {
  final String shopGuid;
  const ClearState(this.shopGuid);

  @override
  List<Object> get props => [shopGuid];
}

class LoadCheckoutData extends LocalCheckoutEvent {
  final String shopGuid;
  const LoadCheckoutData(this.shopGuid);

  @override
  List<Object> get props => [shopGuid];
}
