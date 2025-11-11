import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/featuries/admin/persons/pages/list/state/person_list_cubit.dart';
import 'package:flirta/featuries/admin/persons/pages/list/widget/fragments/person_list_data_fragment.dart';
import 'package:flirta/featuries/admin/persons/pages/list/widget/fragments/person_list_error_fragment.dart';
import 'package:flirta/featuries/admin/persons/pages/list/widget/fragments/person_list_loader_fragment.dart';
import 'package:flirta/featuries/admin/persons/pages/list/widget/person_list_builder.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class PersonsAdminPage extends StatefulWidget {
  const PersonsAdminPage({
    super.key,
    required this.onCreateNewModel,
    required this.onDetailModel,
  });

  final Function onCreateNewModel;
  final Function(PersonModel person) onDetailModel;

  @override
  State<PersonsAdminPage> createState() => _PersonsAdminPageState();
}

class _PersonsAdminPageState extends State<PersonsAdminPage> {
  @override
  void initState() {
    super.initState();

    getIt<PersonListCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(LocaleKeys.admin_persons_title.tr()),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_circle,
              color: AppTheme.of(context).color.primaryDarkset,
            ),
            onPressed: () => widget.onCreateNewModel(),
          ),
        ],
      ),
      body: PersonListBuilder(
        init: (context) => PersonListLoaderFragment(),
        loading: (context) => PersonListLoaderFragment(),
        error: (context, value, child) =>
            PersonListErrorFragment(error: value.toString()),
        success: (context, value, child) => PersonListDataFragment(
          persons: value,
          onTap: (person) => widget.onDetailModel(person),
        ),
      ),
    );
  }
}
