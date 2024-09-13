import 'package:coffee_start/features/card/domain/entities/card.dart';

class PayOrderParams {
  String orderId;
  CardEntity cardEntity;

  PayOrderParams(this.orderId, this.cardEntity);
}
