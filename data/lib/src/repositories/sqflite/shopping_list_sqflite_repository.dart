import 'package:data/data.dart';
import 'package:domain/domain.dart';

class ShoppingListSQFliteRepository implements ShoppingListRepository {
  ShoppingListSQFliteRepository({
    required SqfliteDatabase database,
  }) : _database = database;

  final SqfliteDatabase _database;

  @override
  Future<void> add(ShoppingList item) async {
    final dbItem = ShoppingListSqfliteMapper().map(item);
    await _database.insert(
      SqfliteShoppingListFields.table,
      values: dbItem.toJson(),
    );
  }

  @override
  Future<void> addAll(List<ShoppingList> items) async {
    final listMapper = TwoWaysListMapper<ShoppingList, SqfliteShoppingList>(
      ShoppingListSqfliteMapper(),
    );

    final dbItems = listMapper.map(items);

    await _database.insertAll(
      SqfliteShoppingListFields.table,
      values: dbItems.map((dbItem) => dbItem.toJson()).toList(),
    );
  }

  @override
  Future<List<ShoppingList>> findAll() async {
    var rs = await _database.query(
      SqfliteShoppingListFields.table,
      columns: SqfliteShoppingListFields.fields,
    );

    var dbItems = SqfliteShoppingList.fromDynamicList(rs);

    final listMapper = TwoWaysListMapper<ShoppingList, SqfliteShoppingList>(
      ShoppingListSqfliteMapper(),
    );

    return listMapper.inverseMap(dbItems);
  }

  @override
  Future<List<ShoppingList>> query(SearchCriteria criteria) async {
    // TODO: implement query
    return List.empty();
  }

  @override
  Future<void> remove(ShoppingList item) async {
    await _database.delete(
      SqfliteShoppingListFields.table,
      columnId: SqfliteShoppingListFields.id,
      ids: [item.id],
    );
  }

  @override
  Future<void> removeAll(List<ShoppingList> items) async {
    await _database.delete(
      SqfliteShoppingListFields.table,
      columnId: SqfliteShoppingListFields.id,
      ids: items.map((item) => item.id).toList(),
    );
  }

  @override
  Future<void> removeWhere(SearchCriteria criteria) async {
    // TODO: implement removeWhere
  }
}
