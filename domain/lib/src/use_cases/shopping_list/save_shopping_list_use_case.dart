import 'package:domain/domain.dart';

class SaveShoppingListUseCase implements UseCase<void> {
  SaveShoppingListUseCase({
    required ShoppingListRepository shoppingListRepository,
  }) : _shoppingListRepository = shoppingListRepository;

  final ShoppingListRepository _shoppingListRepository;

  late ShoppingList shoppingList;

  @override
  Future<void> execute() => _shoppingListRepository.add(shoppingList);
}
