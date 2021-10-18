import 'package:domain/domain.dart';
import 'package:logging/logging.dart';

class ItemMemoryRepository implements ItemRepository {
  static final Logger _logger = Logger('CategoryMemoryRepository');

  final Map<String, Item> _defaultItems = {};

  @override
  Future<void> add(Item item) async {
    _defaultItems[item.id] = item;
  }

  @override
  Future<void> addAll(List<Item> items) async {
    items.forEach((item) => _defaultItems[item.id] = item);
  }

  @override
  Future<List<Item>> findAll() async {
    return _defaultItems.values.toList();
  }

  @override
  Future<List<Item>> query(SearchCriteria criteria) async {
    final map = criteria.toParamMap();
    final results = _defaultItems.values
        .where(
          (item) => item.shoppingListId == map['shoppingListId'],
        )
        .toList(growable: false);
    return results;
  }

  @override
  Future<void> remove(Item item) async {
    _defaultItems.remove(item.id);
  }

  @override
  Future<void> removeAll(List<Item> items) async {
    _defaultItems.clear();
  }

  @override
  Future<void> removeWhere(SearchCriteria criteria) async {
    _logger.finest('Removing where $criteria');
  }
}
