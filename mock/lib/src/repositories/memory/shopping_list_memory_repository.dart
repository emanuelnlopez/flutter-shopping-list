import 'package:domain/domain.dart';
import 'package:logging/logging.dart';

class ShoppingListMemoryRepository implements ShoppingListRepository {
  static final Logger _logger = Logger('ShoppingListMockRepository');

  final Map<String, ShoppingList> _defaultShoppingList = {};

  @override
  Future<void> add(ShoppingList item) async {
    _defaultShoppingList[item.id] = item;
  }

  @override
  Future<void> addAll(List<ShoppingList> items) async {
    items.forEach((item) => _defaultShoppingList[item.id] = item);
  }

  @override
  Future<List<ShoppingList>> findAll() async {
    return _defaultShoppingList.values.toList();
  }

  @override
  Future<List<ShoppingList>> query(SearchCriteria criteria) async {
    return List.empty(growable: false);
  }

  @override
  Future<void> remove(ShoppingList item) async {
    _defaultShoppingList.remove(item.id);
  }

  @override
  Future<void> removeAll(List<ShoppingList> items) async {
    _defaultShoppingList.clear();
  }

  @override
  Future<void> removeWhere(SearchCriteria criteria) async {
    _logger.finest('Removing where $criteria');
  }
}
