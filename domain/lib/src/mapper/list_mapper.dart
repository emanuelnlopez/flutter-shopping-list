import 'package:domain/domain.dart';

class ListMapper<M, P> extends Mapper<List<M>, List<P>> {
  ListMapper(this._mapper);

  final Mapper<M, P> _mapper;

  @override
  List<P> map(List<M>? models) =>
      models?.map((model) => _mapper.map(model)).toList() ?? <P>[];
}
