import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetDetailOfPerson {
  final DatingRepository _datingRepository;

  GetDetailOfPerson({required DatingRepository datingRepository})
    : _datingRepository = datingRepository;

  Future<Either<DatingError, Person>> call(String modelId) async {
    var result = await _datingRepository.getDetailOfPerson(
      GetDetailOfPersonBody(modelId: modelId),
    );

    return result;
  }
}
