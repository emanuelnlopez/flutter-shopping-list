import 'package:domain/domain.dart';

abstract class Repository<S, T> {
  Future<void> add(T item);

  Future<void> addAll(List<T> items);

  Future<List<T>> findAll();

  Future<List<T>> query(SearchCriteria criteria);

  Future<void> remove(T item);

  Future<void> removeAll(List<T> items);

  Future<void> removeWhere(SearchCriteria criteria);
}
