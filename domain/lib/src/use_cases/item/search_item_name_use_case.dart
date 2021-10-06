import 'package:domain/domain.dart';

class SearchItemNameUseCase implements UseCase<List<String>> {
  SearchItemNameUseCase({
    required ItemNameRepository itemNameRepository,
  }) : _itemNameRepository = itemNameRepository;

  final ItemNameRepository _itemNameRepository;

  late String query;

  @override
  Future<List<String>> execute() => _itemNameRepository.search(query);
}
