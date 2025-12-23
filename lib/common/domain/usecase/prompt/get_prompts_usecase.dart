import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetPrompts {
  final PromptRepository _promptRepository;

  GetPrompts({required PromptRepository promptRepository})
    : _promptRepository = promptRepository;

  Future<Either<PromptRepositoryError, Prompts>> call() async {
    var result = await _promptRepository.getPrompts();
    return result;
  }
}
