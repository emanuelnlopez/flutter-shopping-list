import 'package:data/data.dart';
import 'package:domain/domain.dart';

class CategorySqfliteMapper
    implements TwoWaysMapper<Category, SqfliteCategory> {
  @override
  Category inverseMap(SqfliteCategory persistence) => Category(
        id: persistence.id,
        name: persistence.name,
      );

  @override
  SqfliteCategory map(Category model) => SqfliteCategory(
        id: model.id,
        name: model.name,
      );
}
