import 'package:domain/domain.dart';

class SaveCategoryUseCase implements UseCase<void> {
  SaveCategoryUseCase(this._categoryRepository);

  final CategoryRepository _categoryRepository;

  late Category category;

  @override
  Future<void> execute() => _categoryRepository.add(category);
}
