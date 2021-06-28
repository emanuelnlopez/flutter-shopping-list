import 'package:domain/domain.dart';
import 'package:logging/logging.dart';

class CategoryMemoryRepository implements CategoryRepository {
  static final Logger _logger = Logger('CategoryMemoryRepository');

  final _defaultCategories = {
    '1': Category(
      id: '1',
      name: 'Bathroom',
    ),
    '2': Category(
      id: '2',
      name: 'Cleaning',
    ),
    '3': Category(
      id: '3',
      name: 'Food',
    ),
    '4': Category(
      id: '4',
      name: 'Breakfast',
    ),
  };

  @override
  Future<void> add(Category item) async {
    _defaultCategories[item.id] = item;
  }

  @override
  Future<void> addAll(List<Category> items) async {
    items.forEach((item) => _defaultCategories[item.id] = item);
  }

  @override
  Future<List<Category>> findAll() async {
    return _defaultCategories.values.toList();
  }

  @override
  Future<List<Category>> query(SearchCriteria criteria) async {
    return List.empty(growable: false);
  }

  @override
  Future<void> remove(Category item) async {
    _defaultCategories.remove(item.id);
  }

  @override
  Future<void> removeAll(List<Category> items) async {
    _defaultCategories.clear();
  }

  @override
  Future<void> removeWhere(SearchCriteria criteria) async {
    _logger.finest('Removing where $criteria');
  }
}
