import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/service/services.dart';
import 'package:flirta/common/ui/widgets/logo/logo.dart';
import 'package:flirta/featuries/dating/pages/dating/state/dating_cubit.dart';
import 'package:flirta/featuries/dating/pages/dating/widgets/dating_widgets.dart';
import 'package:flirta/featuries/dating/pages/dating/widgets/fragments/dating_list_completed_no_premium_fragment.dart';
import 'package:flirta/featuries/dating/pages/dating/widgets/fragments/dating_list_completed_premium_fragment.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class DatingPage extends StatefulWidget {
  const DatingPage({
    super.key,
    required this.onFilter,
    required this.onDetailPerson,
    required this.onMatch,
    required this.onPayWall,
    required this.onDetailChat,
  });

  final VoidCallback onFilter;
  final Function() onPayWall;
  final Future<bool> Function({required Person person}) onMatch;
  final Future<ActionCallBackPersonDetailEnums> Function({
    required Person person,
  })
  onDetailPerson;
  final Future<bool> Function({required String modelId}) onDetailChat;

  @override
  State<DatingPage> createState() => _DatingPageState();
}

class _DatingPageState extends State<DatingPage> {
  @override
  void initState() {
    super.initState();

    getIt<DatingCubit>().getListDatingPerson();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPremium = getIt<AppStateService>().isPremium;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const LogoFlirta(),
        actions: [
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Assets.images.icons.filter.svg(),
            ),
            onPressed: widget.onFilter,
          ),
        ],
      ),
      body: DatingBuilder(
        init: (context) => DatingListLoaderFragment(),
        loading: (context) => DatingListLoaderFragment(),
        error: (context, value, child) =>
            DatingListEmptyFragment(onRefresh: widget.onFilter),
        empty: (BuildContext context) =>
            DatingListEmptyFragment(onRefresh: widget.onFilter),
        completed: (context) => isPremium
            ? DatingListCompletedPremiumFragment(onRefresh: () {})
            : DatingListCompletedNoPremiumFragment(onRefresh: widget.onPayWall),
        success: (context, value, child) => DatingListDataFragment(
          persons: value,
          onDetailPerson: widget.onDetailPerson,
          onMatch: (person) async {
            var openDetailChat = await widget.onMatch(person: person);
            if (openDetailChat) {
              widget.onDetailChat(modelId: person.modelId);
            }
            return openDetailChat;
          },
          onPayWall: widget.onPayWall,
        ),
      ),
    );
  }
}
