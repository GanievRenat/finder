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
