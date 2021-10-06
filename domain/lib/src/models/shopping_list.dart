import 'package:domain/domain.dart';
import 'package:uuid/uuid.dart';

class ShoppingList implements IShoppingList {
  ShoppingList({
    required this.creationDate,
    String? id,
    required this.name,
  }) : id = id ?? Uuid().v4();

  @override
  final DateTime creationDate;
  @override
  final String id;
  @override
  final String name;
}
