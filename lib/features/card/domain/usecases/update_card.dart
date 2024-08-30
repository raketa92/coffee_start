import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/card/domain/repository/card_repository_local.dart';

class UpdateCardUseCase implements UseCase<CardEntity, CardEntity> {
  final CardRepositoryLocal _cardRepositoryLocal;
  UpdateCardUseCase(this._cardRepositoryLocal);

  @override
  Future<CardEntity> call({CardEntity? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _cardRepositoryLocal.updateCard(params);
  }
}
