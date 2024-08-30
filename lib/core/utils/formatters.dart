String formatCardNumber(String cardNumber) {
  String result = "";
  for (var i = 0; i < cardNumber.length; i++) {
    int index = i + 1;
    if (index > 4 && index < 13) {
      result += "*";
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
