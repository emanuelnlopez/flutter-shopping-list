import 'package:data/data.dart';
import 'package:data/src/mapper/sqflite/category_sqflite_mapper.dart';
import 'package:data/src/models/sqflite/sqflite_category.dart';
import 'package:domain/domain.dart';

class CategorySqfliteRepository implements CategoryRepository {
  CategorySqfliteRepository({
    required SqfliteDatabase database,
  }) : _database = database;

  final SqfliteDatabase _database;

  @override
  Future<void> add(Category item) async {
    final dbItem = CategorySqfliteMapper().map(item);
    await _database.insert(
      SqfliteCategoryFields.table,
      values: dbItem.toJson(),
    );
  }

  @override
  Future<void> addAll(List<Category> items) async {
    final listMapper = TwoWaysListMapper<Category, SqfliteCategory>(
      CategorySqfliteMapper(),
    );

    final dbItems = listMapper.map(items);

    await _database.insertAll(
      SqfliteCategoryFields.table,
      values: dbItems.map((dbItem) => dbItem.toJson()).toList(),
    );
  }

  @override
  Future<List<Category>> findAll() async {
    var rs = await _database.query(
      SqfliteCategoryFields.table,
      columns: SqfliteCategoryFields.fields,
    );

    var dbItems = SqfliteCategory.fromDynamicList(rs);

    final listMapper = TwoWaysListMapper<Category, SqfliteCategory>(
      CategorySqfliteMapper(),
    );

    return listMapper.inverseMap(dbItems);
  }

  @override
  Future<List<Category>> query(SearchCriteria criteria) async {
    // TODO: implement query
    return List.empty();
  }

  @override
  Future<void> remove(Category item) async {
    await _database.delete(
      SqfliteCategoryFields.table,
      columnId: SqfliteCategoryFields.id,
      ids: [item.id],
    );
  }

  @override
  Future<void> removeAll(List<Category> items) async {
    await _database.delete(
      SqfliteCategoryFields.table,
      columnId: SqfliteCategoryFields.id,
      ids: items.map((item) => item.id).toList(),
    );
  }

  @override
  Future<void> removeWhere(SearchCriteria criteria) async {
    // TODO: implement removeWhere
  }
}
