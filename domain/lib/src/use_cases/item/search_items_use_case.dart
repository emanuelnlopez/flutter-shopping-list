import 'package:domain/domain.dart';

class SearchItemsUseCase implements UseCase<List<Item>> {
  SearchItemsUseCase({
    required ItemRepository itemRepository,
  }) : _itemRepository = itemRepository;

  final ItemRepository _itemRepository;

  late ItemSearchCriteria itemSearchCriteria;

  @override
  Future<List<Item>> execute() => _itemRepository.query(itemSearchCriteria);
}
