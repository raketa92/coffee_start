import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/card/domain/repository/card_repository_local.dart';

class GetCardsUseCase implements UseCase<List<CardEntity>, void> {
  final CardRepositoryLocal _cardRepositoryLocal;
  GetCardsUseCase(this._cardRepositoryLocal);

  @override
  Future<List<CardEntity>> call({void params}) {
    return _cardRepositoryLocal.getCards();
  }
}
