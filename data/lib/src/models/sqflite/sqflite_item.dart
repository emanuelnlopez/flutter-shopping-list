import 'package:dart_utils/dart_utils.dart';
import 'package:domain/domain.dart';

class SqfliteItem implements IItem {
  SqfliteItem({
    this.categoryId,
    required this.id,
    required this.name,
    this.price,
    this.purchaseDate,
    this.quantity = 1,
    required this.shoppingListId,
  });

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

  static SqfliteItem? fromDynamic(dynamic map) {
    SqfliteItem? result;

    if (map?.isNotEmpty == true) {
      result = SqfliteItem(
        categoryId: map['categoryId'],
        id: map['id'],
        name: map['name'],
        price: ParseUtils.parseDouble(map['price']),
        purchaseDate: DateTimeFormat.parseMillis(
          map['purchaseDate'],
        ),
        quantity: ParseUtils.parseInt(map['quantity']) ?? 1,
        shoppingListId: map['shoppingListId'],
      );
    }

    return result;
  }

  static List<SqfliteItem>? fromDynamicList(dynamic list) {
    List<SqfliteItem>? result;

    if (list != null) {
      result = [];
      for (dynamic map in list) {
        result.add(fromDynamic(map)!);
      }
    }

    return result;
  }

  Map<String, dynamic> toJson() => {
        SqfliteItemFields.categoryId: categoryId,
        SqfliteItemFields.id: id,
        SqfliteItemFields.name: name,
        SqfliteItemFields.price: price,
        SqfliteItemFields.purchaseDate: purchaseDate?.millisecondsSinceEpoch,
        SqfliteItemFields.quantity: quantity,
        SqfliteItemFields.shoppingListId: shoppingListId,
      };
}

class SqfliteItemFields {
  static final table = 'items';

  static final categoryId = 'creationDate';
  static final id = 'id';
  static final name = 'name';
  static final price = 'price';
  static final purchaseDate = 'purchaseDate';
  static final quantity = 'quantity';
  static final shoppingListId = 'shoppingListId';

  static final List<String> fields = [
    categoryId,
    id,
    name,
    price,
    quantity,
    shoppingListId,
  ];
}
