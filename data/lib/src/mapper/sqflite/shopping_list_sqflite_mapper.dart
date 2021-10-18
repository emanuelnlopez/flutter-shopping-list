import 'package:data/data.dart';
import 'package:domain/domain.dart';

class ShoppingListSqfliteMapper
    implements TwoWaysMapper<ShoppingList, SqfliteShoppingList> {
  @override
  ShoppingList inverseMap(SqfliteShoppingList persistence) => ShoppingList(
        creationDate: persistence.creationDate,
        id: persistence.id,
        name: persistence.name,
      );

  @override
  SqfliteShoppingList map(ShoppingList model) => SqfliteShoppingList(
        creationDate: model.creationDate,
        id: model.id,
        name: model.name,
      );
}
