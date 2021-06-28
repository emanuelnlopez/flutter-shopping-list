import 'package:domain/domain.dart';

class SaveItemUseCase implements UseCase<void> {
  SaveItemUseCase({
    required ItemRepository itemRepository,
  }) : _itemRepository = itemRepository;

  final ItemRepository _itemRepository;

  late Item item;

  @override
  Future<void> execute() => _itemRepository.add(item);
}
