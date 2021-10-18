import 'package:data/data.dart';
import 'package:domain/domain.dart';

class ItemSqfliteMapper implements TwoWaysMapper<Item, SqfliteItem> {
  @override
  Item inverseMap(SqfliteItem persistence) => Item(
        categoryId: persistence.categoryId,
        id: persistence.id,
        name: persistence.name,
        price: persistence.price,
        purchaseDate: persistence.purchaseDate,
        shoppingListId: persistence.shoppingListId,
      );

  @override
  SqfliteItem map(Item model) => SqfliteItem(
        categoryId: model.categoryId,
        id: model.id,
        name: model.name,
        price: model.price,
        purchaseDate: model.purchaseDate,
        shoppingListId: model.shoppingListId,
      );
}
