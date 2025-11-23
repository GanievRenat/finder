import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/action_callback_person_detail.dart';
import 'package:flirta/featuries/dating/pages/dating/state/dating_cubit.dart';
import 'package:flirta/featuries/dating/pages/dating/widgets/dating_widgets.dart';
import 'package:flutter/material.dart';

class DatingListDataFragment extends StatelessWidget {
  const DatingListDataFragment({
    super.key,
    required this.persons,
    required this.onDetailPerson,
    required this.onMatch,
    required this.onPayWall,
  });

  final List<Person> persons;
  final Future<ActionCallBackPersonDetailEnums> Function({
    required Person person,
  })
  onDetailPerson;
  final Function(Person person) onMatch;
  final Function() onPayWall;

  @override
  Widget build(BuildContext context) {
    return CardsSwiper(
      persons: persons,
      onTapToPerson: onDetailPerson,
      onPayWall: onPayWall,
      onLike: (person) async {
        //
        await getIt<DatingCubit>().like(person);
        onMatch(person);
      },
      onSkip: (person) async {
        await getIt<DatingCubit>().skip(person);
      },
      onUndo: () async {
        await getIt<DatingCubit>().undo();
      },
      canSwipe: () => getIt<DatingCubit>().canSwipe(),
      canUndo: () => getIt<DatingCubit>().canUndo(),
      onEnd: () => getIt<DatingCubit>().setEmptyState(),
    );
  }
}
