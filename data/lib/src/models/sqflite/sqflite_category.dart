import 'package:domain/domain.dart';

class SqfliteCategory implements ICategory {
  SqfliteCategory({
    required this.id,
    required this.name,
  });

  @override
  final String id;
  @override
  final String name;

  static SqfliteCategory? fromDynamic(dynamic map) {
    SqfliteCategory? result;

    if (map?.isNotEmpty == true) {
      result = SqfliteCategory(
        id: map['id'],
        name: map['name'],
      );
    }

    return result;
  }

  static List<SqfliteCategory>? fromDynamicList(dynamic list) {
    List<SqfliteCategory>? result;

    if (list != null) {
      result = [];
      for (dynamic map in list) {
        result.add(fromDynamic(map)!);
      }
    }

    return result;
  }

  Map<String, dynamic> toJson() => {
        SqfliteCategoryFields.id: id,
        SqfliteCategoryFields.name: name,
      };
}

class SqfliteCategoryFields {
  static final table = 'categories';

  static final id = 'id';
  static final name = 'name';

  static final List<String> fields = [
    id,
    name,
  ];
}
