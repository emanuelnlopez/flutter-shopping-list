import 'package:flutter/services.dart';

class SqlStatements {
  static const CREATE_CATEGORY_TABLE = 'create_category_table.sql';
  static const CREATE_ITEM_TABLE = 'create_item_table.sql';
  static const CREATE_SHOPPING_LIST_TABLE = 'create_shopping_list_table.sql';

  static const INSERT_CATEGORY = 'insert_category.sql';
  static const INSERT_ITEM = 'insert_item.sql';
  static const INSERT_SHOPPING_LIST = 'insert_shopping_list.sql';

  static const List<String> _all = [
    INSERT_CATEGORY,
    INSERT_ITEM,
    INSERT_SHOPPING_LIST,
  ];

  static const List<String> _create = [
    CREATE_CATEGORY_TABLE,
    CREATE_SHOPPING_LIST_TABLE,
    CREATE_ITEM_TABLE,
  ];

  static const _package = 'data';

  final List<String> createStatements = [];
  final Map<String, String> statements = {};

  Future<void> initialize() async {
    for (var file in _all) {
      statements[file] = await _loadStatement(
        file: file,
        package: _package,
      );
    }

    for (var file in _create) {
      createStatements.add(
        await _loadStatement(
          file: file,
          package: _package,
        ),
      );
    }
  }

  String _getKey({
    required String file,
    String? package,
  }) =>
      package?.isNotEmpty == true
          ? 'packages/$package/assets/sql/$file'
          : 'assets/sql/$file';

  Future<String> _loadStatement({
    required String file,
    String? package,
  }) async {
    var key = _getKey(
      file: file,
      package: package,
    );
    return await rootBundle.loadString(key);
  }
}
