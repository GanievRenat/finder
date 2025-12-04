import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/featuries/chat/state/chat_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'dating_state.dart';
part 'dating_cubit.freezed.dart';

@singleton
class DatingCubit extends Cubit<DatingState> {
  DatingCubit({
    required GetListDatingPerson getListDatingPerson,
    required LikePerson likePerson,
    required SkipPerson skipPerson,
    required UndoLast undoLast,
    required GetSwipeCountToDay countToDay,
    required DeleteOlderData deleteOlderData,
    required AppStateService appStateService,
    required ChatCubit chatCubit,
  }) : _getListDatingPerson = getListDatingPerson,
       _likePerson = likePerson,
       _skipPerson = skipPerson,
       _undoLast = undoLast,
       _countToDay = countToDay,
       _deleteOlderData = deleteOlderData,
       _appStateService = appStateService,
       _chatCubit = chatCubit,
       super(DatingState.init());

  final GetListDatingPerson _getListDatingPerson;

  final LikePerson _likePerson;
  final SkipPerson _skipPerson;
  final UndoLast _undoLast;
  final GetSwipeCountToDay _countToDay;
  final AppStateService _appStateService;
  final DeleteOlderData _deleteOlderData;
  final ChatCubit _chatCubit;

  int _swipeCountToday = 0;

  Future<void> init() async {
    // Загрузить кол-во лайков за сутки
    _swipeCountToday = await _countToDay();
    // Убираем из блокировок все модели если заблокировали более 7 дней назад.
    await _deleteOlderData();
  }

  void setEmptyState() {
    emit(DatingState.empty());
  }

  void setCompletedState() {
    emit(DatingState.complited());
  }

  void getListDatingPerson() async {
    emit(DatingState.loading());

    var result = await _getListDatingPerson();
    if (result.isRight) {
      if (result.right.isNotEmpty) {
        emit(DatingState.data(result.right));
      } else {
        emit(DatingState.empty());
      }
    } else {
      emit(DatingState.error(result.left.errorText));
    }
  }

  bool canSwipe() {
    if (_appStateService.isPremium) {
      return (_swipeCountToday < 10);
    } else {
      return (_swipeCountToday < 2);
    }
  }

  bool canUndo() => _appStateService.isPremium;

  Future<void> like(Person person) async {
    if (canSwipe()) {
      var result = await _likePerson(person);
      _chatCubit.newChat(person: person);
      if (result) {
        _swipeCountToday++;
      }
    }
  }

  Future<void> skip(Person person) async {
    if (canSwipe()) {
      var result = await _skipPerson(person);
      if (result) {
        _swipeCountToday++;
      }
    }
  }

  Future<void> undo() async {
    if (canUndo()) {
      var result = await _undoLast();
      if (result) {
        _swipeCountToday--;
      }
    }
  }
}
