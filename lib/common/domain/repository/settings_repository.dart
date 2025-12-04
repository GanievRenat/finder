import 'package:flirta/common/domain/entites/entities.dart';
import 'package:either_dart/either.dart';

abstract class SettingsRepository {
  Future<Either<Exception, Settings>> getSettings();
  Future<Either<Exception, bool>> updatet(Settings settings);
  Future<bool> clear(String userUid);
}
