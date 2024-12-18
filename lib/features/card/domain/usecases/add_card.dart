import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/card/domain/repository/card_repository_local.dart';

class AddCardUseCase implements UseCase<void, CardEntity> {
  final CardRepositoryLocal _cardRepositoryLocal;
  AddCardUseCase(this._cardRepositoryLocal);

  @override
  Future<void> call({CardEntity? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _cardRepositoryLocal.addCard(params);
  }
}
