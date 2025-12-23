import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class UpdatePrompts {
  final PromptRepository _promptRepository;

  UpdatePrompts({required PromptRepository promptRepository})
    : _promptRepository = promptRepository;

  Future<Either<PromptRepositoryError, bool>> call(Prompts newPrompts) async {
    var result = await _promptRepository.update(newPrompts);
    return result;
  }
}
