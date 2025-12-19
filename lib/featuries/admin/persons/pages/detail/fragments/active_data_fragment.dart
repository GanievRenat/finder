import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class ActiveDataFragment extends StatefulWidget {
  const ActiveDataFragment({super.key});

  @override
  State<ActiveDataFragment> createState() => _ActiveDataFragmentState();
}

class _ActiveDataFragmentState extends State<ActiveDataFragment> {
  bool active = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<PersonDetailState>().personModel;
    active = state?.modelActive ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ContainerGroup(
      title: active ? 'ACTIVE' : 'NO ACTIVE',
      child: SwitchListTile(
        value: active,
        onChanged: (value) {
          setState(() {
            active = value;
          });
          final state = context.read<PersonDetailState>().personModel;
          context.read<PersonDetailState>().setNewState(
            state == null
                ? PersonModel(modelActive: value)
                : state.copyWith(modelActive: value),
          );
        },
        contentPadding: EdgeInsets.zero,
        title: Text(
          'Показывать в мобильном приложении:',
          style: TextStyle(color: active ? Colors.green : Colors.red),
        ),
      ),
    );
  }
}
