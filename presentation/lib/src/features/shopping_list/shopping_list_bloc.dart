import 'dart:async';

import 'package:domain/domain.dart';
import 'package:presentation/presentation.dart';

class ShoppingListBloc implements Bloc {
  ShoppingListBloc({
    required SearchItemNameUseCase searchItemNameUseCase,
    required SaveItemUseCase saveItemUseCase,
    required SearchItemsUseCase searchItemsUseCase,
  })  : _searchItemNameUseCase = searchItemNameUseCase,
        _saveItemUseCase = saveItemUseCase,
        _searchItemsUseCase = searchItemsUseCase;

  final StreamController<List<String>> _itemNameController =
      StreamController<List<String>>.broadcast();
  final SearchItemNameUseCase _searchItemNameUseCase;
  final StreamController<List<Item>> _itemsController =
      StreamController<List<Item>>.broadcast();
  final SaveItemUseCase _saveItemUseCase;
  final SearchItemsUseCase _searchItemsUseCase;

  Stream<List<String>> get itemNameStream => _itemNameController.stream;
  Stream<List<Item>> get itemsStream => _itemsController.stream;

  @override
  void dispose() {
    _itemNameController.close();
    _itemsController.close();
  }

  void addItem({required Item item}) async {
    _saveItemUseCase.item = item;
    await _saveItemUseCase.execute();
    loadItems(shoppingListId: item.shoppingListId);
  }

  void loadItems({required String shoppingListId}) async {
    _searchItemsUseCase.itemSearchCriteria = ItemSearchCriteria(
      shoppingListId: shoppingListId,
    );
    final items = await _searchItemsUseCase.execute();
    _itemsController.sink.add(items);
  }

  void search({required String barCode}) async {
    _searchItemNameUseCase.query = barCode;
    final result = await _searchItemNameUseCase.execute();
    _itemNameController.sink.add(result);
  }
}
