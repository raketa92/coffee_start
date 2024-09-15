const String apiBaseUrl = 'http://localhost:3000';
const String likedProductsLocalStorageKey = 'liked_products';
const String cartItemsLocalStorageKey = 'cart_items';
const String cardsLocalStorageKey = 'cards';

class PaymentMethods {
  static const String card = 'card';
  static const String cash = 'cash';
}

enum OrderStatuses { pending, completed, canceled }
