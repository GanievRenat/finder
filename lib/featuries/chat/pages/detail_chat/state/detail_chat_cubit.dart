import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/featuries/chat/state/chat_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_chat_state.dart';
part 'detail_chat_cubit.freezed.dart';

class DetailChatCubit extends Cubit<DetailChatState> {
  DetailChatCubit({
    required String modelId,
    required GetDetailOfPerson getDetailOfPerson,
    required ChatCubit chatCubit,
  }) : _getDetailOfPerson = getDetailOfPerson,
       _modelId = modelId,
       _chatCubit = chatCubit,
       super(DetailChatState.init()) {
    init();
  }

  final String _modelId;
  final GetDetailOfPerson _getDetailOfPerson;
  final ChatCubit _chatCubit;

  Future<void> init() async {
    getDetailChat();
  }

  void getDetailChat() async {
    emit(DetailChatState.loading());
    var resultDetailPerson = await _getDetailOfPerson(_modelId);
    if (resultDetailPerson.isRight) {
      emit(DetailChatState.data(resultDetailPerson.right));
      _chatCubit.setReadChat(_modelId);
    } else {
      emit(DetailChatState.error(resultDetailPerson.left.errorText));
    }
  }
}
