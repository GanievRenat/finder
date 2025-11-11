import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class ChatDataFragment extends StatelessWidget {
  const ChatDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Chat',
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(label: Text('Behavior')),
            minLines: 10,
            maxLines: 10,
            keyboardType: TextInputType.multiline,
            initialValue: state?.chatBehavior,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(chatBehavior: value)
                    : state.copyWith(chatBehavior: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
