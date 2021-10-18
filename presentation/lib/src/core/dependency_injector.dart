import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injector/injector.dart';
import 'package:mock/mock.dart';
import 'package:presentation/presentation.dart';

enum Environment { prod, mock }

class DependencyInjector {
  factory DependencyInjector() => _instance;

  DependencyInjector._internal();

  static final DependencyInjector _instance = DependencyInjector._internal();

  final injector = Injector.appInstance;

  void initialize({required Environment environment}) {
    _initilizeBlocs();
    _initilizeUseCases();
    _initializeRepositories(environment);
  }

  void _initilizeBlocs() {
    injector.registerDependency<HomeBloc>(
      () => HomeBloc(
        loadShoppingListsUseCase: injector.get<LoadShoppingListsUseCase>(),
        saveShoppingListUseCase: injector.get<SaveShoppingListUseCase>(),
      ),
    );

    injector.registerDependency<ShoppingListBloc>(
      () => ShoppingListBloc(
        searchItemNameUseCase: injector.get<SearchItemNameUseCase>(),
        saveItemUseCase: injector.get<SaveItemUseCase>(),
        searchItemsUseCase: injector.get<SearchItemsUseCase>(),
      ),
    );
  }

  void _initilizeUseCases() {
    injector.registerDependency<SearchItemNameUseCase>(
      () => SearchItemNameUseCase(
        itemNameRepository: injector.get<ItemNameRepository>(),
      ),
    );

    injector.registerDependency<LoadShoppingListsUseCase>(
      () => LoadShoppingListsUseCase(
        shoppingListRepository: injector.get<ShoppingListRepository>(),
      ),
    );

    injector.registerDependency<SaveItemUseCase>(
      () => SaveItemUseCase(
        itemRepository: injector.get<ItemRepository>(),
      ),
    );

    injector.registerDependency<SearchItemsUseCase>(
      () => SearchItemsUseCase(
        itemRepository: injector.get<ItemRepository>(),
      ),
    );

    injector.registerDependency<SaveShoppingListUseCase>(
      () => SaveShoppingListUseCase(
        shoppingListRepository: injector.get<ShoppingListRepository>(),
      ),
    );
  }

  void _initializeRepositories(Environment environment) {
    if (environment == Environment.mock) {
      injector.registerSingleton<ItemRepository>(
        () => ItemMemoryRepository(),
      );

      injector.registerSingleton<ShoppingListRepository>(
        () => ShoppingListMemoryRepository(),
      );
    }

    if (environment == Environment.prod) {
      injector.registerSingleton<SqfliteDatabase>(
        () => SqfliteDatabase(),
      );

      // injector.registerDependency<ItemRepository>(
      //   () => ,
      // );
    }

    injector.registerSingleton<ItemNameRepository>(
      () => ItemNameGoogleRepository(),
    );
  }
}
