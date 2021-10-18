import 'package:dart_utils/dart_utils.dart';
import 'package:domain/domain.dart';

class SqfliteShoppingList implements IShoppingList {
  SqfliteShoppingList({
    required this.creationDate,
    required this.id,
    required this.name,
  });

  @override
  final DateTime creationDate;
  @override
  final String id;
  @override
  final String name;

  static SqfliteShoppingList? fromDynamic(dynamic map) {
    SqfliteShoppingList? result;

    if (map?.isNotEmpty == true) {
      result = SqfliteShoppingList(
        creationDate: DateTimeFormat.parseMillis(
          map['creationDate'],
        ),
        id: map['id'],
        name: map['name'],
      );
    }

    return result;
  }

  static List<SqfliteShoppingList>? fromDynamicList(dynamic list) {
    List<SqfliteShoppingList>? result;

    if (list != null) {
      result = [];
      for (dynamic map in list) {
        result.add(fromDynamic(map)!);
      }
    }

    return result;
  }

  Map<String, dynamic> toJson() => {
        SqfliteShoppingListFields.creationDate:
            creationDate.millisecondsSinceEpoch,
        SqfliteShoppingListFields.id: id,
        SqfliteShoppingListFields.name: name,
      };
}

class SqfliteShoppingListFields {
  static final table = 'shopping_lists';

  static final creationDate = 'creationDate';
  static final id = 'id';
  static final name = 'name';

  static final List<String> fields = [
    creationDate,
    id,
    name,
  ];
}
