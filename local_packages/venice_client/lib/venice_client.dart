import 'package:venice_client/common/domain/entities/answer/answer.dart';
import 'package:venice_client/common/domain/entities/message/message.dart';
import 'package:venice_client/common/domain/enums/enums.dart';
import 'package:venice_client/common/domain/usecases/send_message_usecase.dart';
import 'package:venice_client/common/services/app_state_service.dart';

export 'common/domain/entities/answer/answer.dart';
export 'common/domain/entities/message/message.dart';
export 'package:venice_client/common/domain/enums/enums.dart';

import 'common/di/init_di.dart';

class VeniceClient {
  final ModelsEnums _currentModel;

  VeniceClient({ModelsEnums model = ModelsEnums.chat}) : _currentModel = model {
    // init di
    initDi();
  }

  void setKey({required String key}) {
    // setKey
    getIt<VeniceStateService>().setKey = key;
  }

  Future<Answer?> send(List<Message> messages) async {
    var result = await getIt<SendMessage>()(
      model: _currentModel,
      messages: messages,
    );
    if (result.isRight) {
      return result.right;
    }
    return null;
  }
}
