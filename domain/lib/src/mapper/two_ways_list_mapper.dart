import 'package:domain/domain.dart';

class TwoWaysListMapper<M, P> extends TwoWaysMapper<List<M>, List<P>> {
  TwoWaysListMapper(this._mapper);

  final TwoWaysMapper<M, P> _mapper;

  @override
  List<M> inverseMap(List<P>? persistences) =>
      persistences
          ?.map((persistence) => _mapper.inverseMap(persistence))
          .toList() ??
      <M>[];

  @override
  List<P> map(List<M>? models) =>
      models?.map((model) => _mapper.map(model)).toList() ?? <P>[];
}
