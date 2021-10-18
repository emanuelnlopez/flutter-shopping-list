import 'dart:async';

import 'package:domain/domain.dart';
import 'package:presentation/presentation.dart';

class HomeBloc implements Bloc {
  HomeBloc({
    required LoadShoppingListsUseCase loadShoppingListsUseCase,
    required SaveShoppingListUseCase saveShoppingListUseCase,
  })  : _loadShoppingListsUseCase = loadShoppingListsUseCase,
        _saveShoppingListUseCase = saveShoppingListUseCase;

  final LoadShoppingListsUseCase _loadShoppingListsUseCase;
  final SaveShoppingListUseCase _saveShoppingListUseCase;
  final StreamController<List<ShoppingList>> _shoppingListController =
      StreamController<List<ShoppingList>>.broadcast();

  Stream<List<ShoppingList>> get shoppingListStream =>
      _shoppingListController.stream;

  @override
  void dispose() {
    _shoppingListController.close();
  }

  void loadShoppingLists() async {
    var shoppingLists = await _loadShoppingListsUseCase.execute();
    _shoppingListController.sink.add(shoppingLists);
  }

  void saveShoppingList(ShoppingList shoppingList) async {
    _saveShoppingListUseCase.shoppingList = shoppingList;
    await _saveShoppingListUseCase.execute();
    loadShoppingLists();
  }
}
