import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_chat_state.dart';
part 'detail_chat_cubit.freezed.dart';

class DetailChatCubit extends Cubit<DetailChatState> {
  DetailChatCubit({
    required String modelId,
    required GetDetailOfPerson getDetailOfPerson,
  }) : _getDetailOfPerson = getDetailOfPerson,
       _modelId = modelId,
       super(DetailChatState.init()) {
    init();
  }

  final String _modelId;
  final GetDetailOfPerson _getDetailOfPerson;

  Future<void> init() async {
    getDetailChat();
  }

  void getDetailChat() async {
    emit(DetailChatState.loading());
    var resultDetailPerson = await _getDetailOfPerson(_modelId);
    if (resultDetailPerson.isRight) {
      emit(DetailChatState.data(resultDetailPerson.right));
    } else {
      emit(DetailChatState.error(resultDetailPerson.left.errorText));
    }
  }
}


// Текущие доработки по чату
// TODO:  1. При переходе в чат с деталями надо отмечать все сообщения в данном чате прочитанными
// TODO:  2. Виджет с кол-ом не прочитанных сообщений над иконкой
// TODO:  3. При клике на чат, закрывать клавиатуру.
// TODO:  4. Окно чата в отдельном стеке, как самостоятельное окно.
// TODO:  5. Переход в окно чата с метч окна
// TODO:  6. Отправка сообщений при нажатии на кнопку ентер (очистка сообщения)
// TODO:  7. Поставить пока заглушку для отправки фотографий со стороны пользователя
// TODO:  8. Добавить кнопку переход к сввайпам, если список диалогов пуст
// TODO:  9. Переход в профиль модели из чата (?).
// TODO:  10. Сделать возможность выделять текст сообщение чата