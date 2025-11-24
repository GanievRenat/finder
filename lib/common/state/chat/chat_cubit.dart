import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/service/app_state_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

@singleton
class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required GetListDatingPerson getListDatingPerson,
    required LikePerson likePerson,
    required SkipPerson skipPerson,
    required UndoLast undoLast,
    required GetSwipeCountToDay countToDay,
    required DeleteOlderData deleteOlderData,
    required AppStateService appStateService,
  }) : _getListDatingPerson = getListDatingPerson,
       _likePerson = likePerson,
       _skipPerson = skipPerson,
       _undoLast = undoLast,
       _countToDay = countToDay,
       _deleteOlderData = deleteOlderData,
       _appStateService = appStateService,
       super(ChatState.init());

  final GetListDatingPerson _getListDatingPerson;

  final LikePerson _likePerson;
  final SkipPerson _skipPerson;
  final UndoLast _undoLast;
  final GetSwipeCountToDay _countToDay;
  final AppStateService _appStateService;
  final DeleteOlderData _deleteOlderData;

  int _swipeCountToday = 0;

  Future<void> init() async {
    // Загрузить кол-во лайков за сутки
    _swipeCountToday = await _countToDay();
    // Убираем из блокировок все модели если заблокировали более 7 дней назад.
    await _deleteOlderData();
  }
}
