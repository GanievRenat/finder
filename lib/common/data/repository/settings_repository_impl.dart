import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

@Singleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  @override
  Future<Either<Exception, Settings>> getSettings() {
    // TODO: implement getSettings
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, bool>> updatet(Settings settings) {
    // TODO: implement updatet
    throw UnimplementedError();
  }

  @override
  Future<bool> clear(String userUid) async {
    // TODO: implement getSettings
    //throw UnimplementedError();
    return true;
  }
}
