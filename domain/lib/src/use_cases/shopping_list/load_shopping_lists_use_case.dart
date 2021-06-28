import 'package:domain/domain.dart';

class LoadShoppingListsUseCase implements UseCase<List<ShoppingList>> {
  LoadShoppingListsUseCase({
    required ShoppingListRepository shoppingListRepository,
  }) : _shoppingListRepository = shoppingListRepository;

  final ShoppingListRepository _shoppingListRepository;

  @override
  Future<List<ShoppingList>> execute() => _shoppingListRepository.findAll();
}
