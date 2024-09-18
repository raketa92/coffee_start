import 'package:coffee_start/core/constants/constants.dart';

String formatCardNumber(String cardNumber, {String separator = '*'}) {
  String result = "";
  for (var i = 0; i < cardNumber.length; i++) {
    int index = i + 1;
    if (index > 4 && index < 13) {
      result += separator;
    } else {
      result += cardNumber[i];
    }
    if (index % 4 == 0 && cardNumber.length != index) {
      result += " ";
    }
  }
  return result;
}

String formatCardDate(int month, int year) {
  String result = "$month/$year";
  if (month < 10) {
    result = "0$month/$year";
  }
  return result;
}

String getOrderStatus(OrderStatuses status) {
  switch (status) {
    case OrderStatuses.pending:
      return 'pending';
    case OrderStatuses.completed:
      return 'completed';
    case OrderStatuses.canceled:
      return 'canceled';
    default:
      return 'unknown status';
  }
}
