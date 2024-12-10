import 'dart:async';
import 'dart:convert';

import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'local_checkout_event.dart';
part 'local_checkout_state.dart';

class LocalCheckoutBloc extends Bloc<LocalCheckoutEvent, LocalCheckoutState>
    with HydratedMixin {
  final HydratedStorage storage;
  LocalCheckoutBloc(this.storage)
      : super(const LocalCheckoutInitial(currentStep: 0)) {
    on<UpdateContactInfo>(_onUpdateContactInfo);
    on<UpdatePhone>(_onUpdatePhone);
    on<UpdateAddress>(_onUpdateAddress);
    on<UpdatePaymentInfo>(_onUpdatePaymentInfo);
    on<UpdateOrderItemsInfo>(_onUpdateOrderItemsInfo);
    on<UpdateCurrentStep>(_onUpdateCurrentStep);
    on<LoadCheckoutData>(_onLoadCheckoutData);
    on<ClearState>(_onClearState);
  }

  @override
  LocalCheckoutState? fromJson(Map<String, dynamic> json) {
    try {
      final checkoutData = CheckoutData.fromJson(json['checkoutData']);
      final currentStep = json['currentStep'] as int;
      return LocalCheckoutLoaded(
          checkoutData: checkoutData, currentStep: currentStep);
    } catch (e) {
      print("Error LocalCheckoutState fromJson: $e");
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(LocalCheckoutState state) {
    if (state is LocalCheckoutLoaded) {
      return {
        'checkoutData': state.checkoutData.toJson(),
        'currentStep': state.currentStep
      };
    }
    return null;
  }

  FutureOr<void> _onUpdateCurrentStep(
      UpdateCurrentStep event, Emitter<LocalCheckoutState> emit) async {
    final currentState = state;

    if (currentState is LocalCheckoutLoaded) {
      final updatedCheckoutData = currentState.checkoutData;

      emit(LocalCheckoutLoaded(
        checkoutData: updatedCheckoutData,
        currentStep: event.currentStep,
      ));

      await _saveData(updatedCheckoutData, event.currentStep);
    }
  }

  FutureOr<void> _onUpdateContactInfo(
      UpdateContactInfo event, Emitter<LocalCheckoutState> emit) async {
    final currentState = state;
    if (currentState is LocalCheckoutLoaded) {
      final updatedCheckoutData =
          currentState.checkoutData.copyWith(contactInfo: event.contactInfo);
      emit(currentState.copyWith(checkoutData: updatedCheckoutData));
      await _saveData(updatedCheckoutData, currentState.currentStep);
    }
  }

  FutureOr<void> _onUpdatePaymentInfo(
      UpdatePaymentInfo event, Emitter<LocalCheckoutState> emit) async {
    final currentState = state;
    if (currentState is LocalCheckoutLoaded) {
      final updatedCheckoutData =
          currentState.checkoutData.copyWith(paymentInfo: event.paymentInfo);
      emit(currentState.copyWith(checkoutData: updatedCheckoutData));
      await _saveData(updatedCheckoutData, currentState.currentStep);
    }
  }

  FutureOr<void> _onUpdateOrderItemsInfo(
      UpdateOrderItemsInfo event, Emitter<LocalCheckoutState> emit) async {
    final currentState = state;
    if (currentState is LocalCheckoutLoaded) {
      final updatedCheckoutData = currentState.checkoutData
          .copyWith(orderItemsInfo: event.orderItemsInfo);
      emit(currentState.copyWith(checkoutData: updatedCheckoutData));
      await _saveData(updatedCheckoutData, currentState.currentStep);
    }
  }

  FutureOr<void> _onLoadCheckoutData(
      LoadCheckoutData event, Emitter<LocalCheckoutState> emit) async {
    emit(LocalCheckoutLoading());
    final dataMap = await _loadData(event.shopGuid);
    if (dataMap != null) {
      final checkoutData = dataMap['checkoutData'] as CheckoutData;
      final currentStep = dataMap['currentStep'] as int;
      emit(LocalCheckoutLoaded(
          checkoutData: checkoutData, currentStep: currentStep));
    } else {
      emit(LocalCheckoutLoaded(
        checkoutData: CheckoutData(
          shopGuid: event.shopGuid,
          contactInfo: ContactInfo(phone: '', address: ''),
          paymentInfo: PaymentInfo(),
          orderItemsInfo: OrderItemsInfo(totalPrice: 0.0, orderItems: []),
        ),
        currentStep: 0,
      ));
    }
  }

  Future<void> _saveData(CheckoutData checkoutData, int currentStep) async {
    final dataMap = {'checkoutData': checkoutData, 'currentStep': currentStep};
    final jsonString = jsonEncode(dataMap);
    final key = 'checkoutDataStorageKey${checkoutData.shopGuid}';
    await storage.write(key, jsonString);
  }

  Future<void> _removeData(String shopGuid) async {
    final key = 'checkoutDataStorageKey$shopGuid';
    await storage.delete(key);
  }

  Future<Map<String, dynamic>?> _loadData(String shopGuid) async {
    final key = 'checkoutDataStorageKey$shopGuid';
    final jsonString = storage.read(key);
    if (jsonString != null) {
      final dataMap = json.decode(jsonString) as Map<String, dynamic>;
      final checkoutData = CheckoutData.fromJson(dataMap['checkoutData']);
      final currentStep = dataMap['currentStep'] as int;
      return {'checkoutData': checkoutData, 'currentStep': currentStep};
    }
    return null;
  }

  void _onUpdatePhone(
      UpdatePhone event, Emitter<LocalCheckoutState> emit) async {
    final currentState = state;
    if (currentState is LocalCheckoutLoaded) {
      final updatedContactInfo = ContactInfo(
        phone: event.phone,
        address: currentState.checkoutData.contactInfo.address,
      );

      final updatedCheckoutData =
          currentState.checkoutData.copyWith(contactInfo: updatedContactInfo);

      emit(LocalCheckoutLoaded(
        checkoutData: updatedCheckoutData,
        currentStep: currentState.currentStep,
      ));

      await _saveData(updatedCheckoutData, currentState.currentStep);
    }
  }

  void _onUpdateAddress(
      UpdateAddress event, Emitter<LocalCheckoutState> emit) async {
    final currentState = state;
    if (currentState is LocalCheckoutLoaded) {
      final updatedContactInfo = ContactInfo(
        phone: currentState.checkoutData.contactInfo.phone,
        address: event.address,
      );

      final updatedCheckoutData =
          currentState.checkoutData.copyWith(contactInfo: updatedContactInfo);

      emit(LocalCheckoutLoaded(
        checkoutData: updatedCheckoutData,
        currentStep: currentState.currentStep,
      ));

      await _saveData(updatedCheckoutData, currentState.currentStep);
    }
  }

  FutureOr<void> _onClearState(
      ClearState event, Emitter<LocalCheckoutState> emit) async {
    emit(const LocalCheckoutInitial(currentStep: 0));
    await _removeData(event.shopGuid);
  }
}
