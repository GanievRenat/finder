import 'package:flirta/common/domain/entites/entities.dart';
import 'package:injectable/injectable.dart';

@singleton
class CreateNewChat {
  CreateNewChat();

  Future<bool> call(Person person) async {
    return true;
  }
}
