import 'package:domain/domain.dart';

abstract class TwoWaysMapper<M, P> extends Mapper<M, P> {
  M inverseMap(P persistence);
}
