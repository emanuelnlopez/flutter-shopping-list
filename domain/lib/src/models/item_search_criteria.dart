import 'package:domain/domain.dart';

class ItemSearchCriteria extends SearchCriteria {
  ItemSearchCriteria({
    this.categoryId,
    this.id,
    this.name,
    this.shoppingListId,
  });

  String? categoryId;
  String? id;
  String? name;
  String? shoppingListId;

  @override
  Map<String, dynamic> toParamMap() => {
        'categoryId': categoryId,
        'id': id,
        'name': name,
        'shoppingListId': shoppingListId,
      }..removeWhere((dynamic key, dynamic value) => value == null);
}
