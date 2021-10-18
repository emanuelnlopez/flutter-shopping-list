import 'package:data/data.dart';
import 'package:domain/domain.dart';

class ItemSQFliteRepository implements ItemRepository {
  ItemSQFliteRepository({
    required SqfliteDatabase database,
  }) : _database = database;

  final SqfliteDatabase _database;

  @override
  Future<void> add(Item item) async {
    final dbItem = ItemSqfliteMapper().map(item);
    await _database.insert(
      SqfliteItemFields.table,
      values: dbItem.toJson(),
    );
  }

  @override
  Future<void> addAll(List<Item> items) async {
    final listMapper = TwoWaysListMapper<Item, SqfliteItem>(
      ItemSqfliteMapper(),
    );

    final dbItems = listMapper.map(items);

    await _database.insertAll(
      SqfliteItemFields.table,
      values: dbItems.map((dbItem) => dbItem.toJson()).toList(),
    );
  }

  @override
  Future<List<Item>> findAll() async {
    var rs = await _database.query(
      SqfliteItemFields.table,
      columns: SqfliteItemFields.fields,
    );

    var dbItems = SqfliteItem.fromDynamicList(rs);

    final listMapper = TwoWaysListMapper<Item, SqfliteItem>(
      ItemSqfliteMapper(),
    );

    return listMapper.inverseMap(dbItems);
  }

  @override
  Future<List<Item>> query(SearchCriteria criteria) async {
    // TODO: implement query
    return List.empty();
  }

  @override
  Future<void> remove(Item item) async {
    await _database.delete(
      SqfliteItemFields.table,
      columnId: SqfliteItemFields.id,
      ids: [item.id],
    );
  }

  @override
  Future<void> removeAll(List<Item> items) async {
    await _database.delete(
      SqfliteItemFields.table,
      columnId: SqfliteItemFields.id,
      ids: items.map((item) => item.id).toList(),
    );
  }

  @override
  Future<void> removeWhere(SearchCriteria criteria) async {
    // TODO: implement removeWhere
  }
}
