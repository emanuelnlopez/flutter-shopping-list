class Item {
  Item({
    this.categoryId,
    required this.id,
    required this.name,
    this.price,
    required this.shoppingListId,
    this.quantity = 1,
  });

  String? categoryId;
  final String id;
  final String name;
  double? price;
  final String shoppingListId;
  final int quantity;
}
