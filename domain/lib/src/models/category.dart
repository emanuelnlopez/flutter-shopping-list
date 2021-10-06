import 'package:domain/domain.dart';
import 'package:uuid/uuid.dart';

class Category implements ICategory {
  Category({
    String? id,
    required this.name,
  }) : id = id ?? Uuid().v4();

  @override
  final String id;
  @override
  final String name;
}
