import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class ChatFiltersFragment extends StatelessWidget {
  const ChatFiltersFragment({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.read<PersonDetailState>().personModel;

    if ((state?.chatFilter ?? '').isEmpty) {
      context.read<PersonDetailState>().setNewState(
        state?.copyWith(chatBehavior: kChatFilters),
      );
      state = context.read<PersonDetailState>().personModel;
    }

    return ContainerGroup(
      title: 'Filters',
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(label: Text('Filters')),
            minLines: 10,
            maxLines: 10,
            keyboardType: TextInputType.multiline,
            initialValue: state?.chatFilter,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(chatFilter: value)
                    : state.copyWith(chatFilter: value),
              );
            },
          ),
        ],
      ),
    );
  }
}

final String kChatFilters = "";
