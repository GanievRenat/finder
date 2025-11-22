import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/ui/widgets/logo/logo.dart';
import 'package:flirta/featuries/dating/pages/dating/state/dating_cubit.dart';
import 'package:flirta/featuries/dating/pages/dating/widgets/dating_widgets.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class DatingPage extends StatefulWidget {
  const DatingPage({
    super.key,
    required this.onFilter,
    required this.onDetailPerson,
    required this.onMatch,
    required this.onPayWall,
  });

  final VoidCallback onFilter;
  final Function() onPayWall;
  final Function({required Person person}) onMatch;
  final Function({required Person person}) onDetailPerson;

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
        error: (context, value, child) => DatingListErrorFragment(error: value),
        empty: (BuildContext context) =>
            DatingListEmptyFragment(onRefresh: () {}),
        success: (context, value, child) => DatingListDataFragment(
          persons: value,
          onDetailPerson: (person) => widget.onDetailPerson(person: person),
          onMatch: (person) => widget.onMatch(person: person),
          onPayWall: widget.onPayWall,
        ),
      ),
    );
  }
}
