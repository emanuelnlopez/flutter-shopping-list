import 'package:domain/domain.dart';
import 'package:uuid/uuid.dart';

class Item implements IItem {
  Item({
    this.categoryId,
    String? id,
    required this.name,
    this.price,
    this.purchaseDate,
    this.quantity = 1,
    required this.shoppingListId,
  }) : id = id ?? Uuid().v4();

  @override
  String? categoryId;
  @override
  final String id;
  @override
  final String name;
  @override
  double? price;
  @override
  DateTime? purchaseDate;
  @override
  final int quantity;
  @override
  final String shoppingListId;
}
