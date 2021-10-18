import 'package:domain/domain.dart';
import 'package:uuid/uuid.dart';

class ShoppingList implements IShoppingList {
  ShoppingList({
    DateTime? creationDate,
    String? id,
    required this.name,
  })  : creationDate = creationDate ?? DateTime.now(),
        id = id ?? Uuid().v4();

  @override
  final DateTime creationDate;
  @override
  final String id;
  @override
  final String name;
}
