const String apiBaseUrl = 'http://localhost:3000';
const String productImageUrl = '$apiBaseUrl/images/product';
const String categoryImageUrl = '$apiBaseUrl/images/category';
const String shopImageUrl = '$apiBaseUrl/images/shop';
const String likedProductsLocalStorageKey = 'liked_products';
const String cartItemsLocalStorageKey = 'cart_items';
const String cardsLocalStorageKey = 'cards';
const String checkoutDataStorageKey = 'checkout_';

class PaymentMethods {
  static const String card = 'card';
  static const String cash = 'cash';
}

enum OrderStatuses { pending, completed, canceled }
