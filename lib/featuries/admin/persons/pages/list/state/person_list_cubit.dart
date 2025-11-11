import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'person_list_state.dart';
part 'person_list_cubit.freezed.dart';

@lazySingleton
class PersonListCubit extends Cubit<PersonListState> {
  final GetPersonList _getPersonList;

  PersonListCubit({required GetPersonList getPersonList})
    : _getPersonList = getPersonList,
      super(PersonListState.init());

  Future<void> init() async {
    emit(PersonListState.loading());
    var result = await _getPersonList(GetPersonByFilterBody(limit: 20));
    if (result.isRight) {
      emit(PersonListState.data(result.right));
    } else {
      emit(PersonListState.error(result.left));
    }
  }
}
