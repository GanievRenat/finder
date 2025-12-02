import 'package:deepseek_client/common/domain/entities/answer/answer.dart';
import 'package:deepseek_client/common/domain/entities/message/message.dart';
import 'package:deepseek_client/common/domain/enums/enums.dart';
import 'package:deepseek_client/common/domain/usecases/send_message_usecase.dart';
import 'package:deepseek_client/common/services/app_state_service.dart';

export 'common/domain/entities/answer/answer.dart';
export 'common/domain/entities/message/message.dart';
export 'package:deepseek_client/common/domain/enums/enums.dart';

import 'common/di/init_di.dart';

class DeepseekClient {
  final ModelsEnums _currentModel;

  DeepseekClient({ModelsEnums model = ModelsEnums.chat})
    : _currentModel = model {
    // init di
    initDi();
  }

  void setKey({required String key}) {
    // setKey
    getIt<DeepSeekStateService>().setKey = key;
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
