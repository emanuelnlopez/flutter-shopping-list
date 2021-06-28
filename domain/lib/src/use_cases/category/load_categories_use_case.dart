import 'package:domain/domain.dart';

class LoadCategoriesUseCase implements UseCase<List<Category>> {
  LoadCategoriesUseCase({
    required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository;

  final CategoryRepository _categoryRepository;

  @override
  Future<List<Category>> execute() => _categoryRepository.findAll();
}
