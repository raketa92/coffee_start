import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/card/domain/repository/card_repository_local.dart';

class RemoveCardUseCase implements UseCase<void, String> {
  final CardRepositoryLocal _cardRepositoryLocal;
  RemoveCardUseCase(this._cardRepositoryLocal);

  @override
  Future<void> call({String? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _cardRepositoryLocal.removeCard(params);
  }
}
