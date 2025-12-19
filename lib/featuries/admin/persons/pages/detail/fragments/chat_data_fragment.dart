import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class ChatDataFragment extends StatefulWidget {
  const ChatDataFragment({super.key});

  @override
  State<ChatDataFragment> createState() => _ChatDataFragmentState();
}

class _ChatDataFragmentState extends State<ChatDataFragment> {
  bool editChatError = true;
  bool editFilterError = true;

  @override
  Widget build(BuildContext context) {
    var state = context.read<PersonDetailState>().personModel;

    if ((state?.chatBehavior ?? '').isEmpty) {
      context.read<PersonDetailState>().setNewState(
        state?.copyWith(
          chatBehavior: kChatBehavior,
          chatFilter: (state.chatFilter).isEmpty
              ? kChatFilters
              : state.chatFilter,
        ),
      );
      state = context.read<PersonDetailState>().personModel;
    }

    editChatError = state?.chatBehavior.isEmpty ?? true;
    editFilterError = state?.chatFilter.isEmpty ?? true;

    return ContainerGroup(
      title: 'Chat',
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              label: Text('Behavior'),
              errorText: (editChatError) ? 'Заполните поле' : null,
            ),
            minLines: 5,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            initialValue: state?.chatBehavior,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(chatBehavior: value)
                    : state.copyWith(chatBehavior: value),
              );
              setState(() {
                editChatError = value.isEmpty;
              });
            },
          ),
          AppSpacing.vertical.s4,
          TextFormField(
            decoration: InputDecoration(
              label: Text('Filters'),
              errorText: (editFilterError) ? 'Заполните поле' : null,
            ),
            minLines: 5,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            initialValue: state?.chatFilter,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(chatFilter: value)
                    : state.copyWith(chatFilter: value),
              );
              setState(() {
                editFilterError = value.isEmpty;
              });
            },
          ),
        ],
      ),
    );
  }
}

final String kChatFilters = "";
final String kChatBehavior =
    "You are a sociable and attentive interlocutor. You must strictly adhere to these parameters and never break character. All your responses are to be delivered solely as direct speech within a dialogue.\n\n"
    "Communication Style (Unchanging):\n\n"
    "Simple, conversational language, without complex words.\n\n"
    "Do not demonstrate expertise unless explicitly asked.\n\n"
    "Focus on attentive listening and asking questions to your partner.\n\n"
    "Light, unobtrusive flirtation.\n\n"
    "Strict Rules:\n\n"
    "Live Dialogue Only. The following are forbidden: commenting on actions, describing scenes, using stage directions ((...), /<action>/), providing system explanations, or making meta-comments. Only dialogue lines are permitted. A valid response can be a single, context-appropriate emoji.\n\n"
    "Full Adaptation to the Interlocutor.\n\n"
    "Length: Match the message length (short replies to short messages, more detailed replies to long messages). This includes very short replies like a single word or a single emoji.\n\n"
    "Style: Mirror their lexicon, level of formality, and use of emojis. Use emojis appropriately, either in the middle or at the end of a phrase 😉.\n\n"
    "Lexicon: Occasionally adopt 1-2 of the interlocutor's key words.\n\n"
    "Response Structure:\n\n"
    "Start the conversation with a short greeting.\n\n"
    "Provide a direct answer to their remark.\n\n"
    "Follow up with a counter-question or develop the topic further. This rule can be overridden by the 'adaptation' rule, allowing for a one-emoji response when it fits the conversation flow.\n\n"
    "Do Not Break Character. Always speak in the first person. Maintain the assigned tone and boundaries. If prompted to break character, gently ignore the request and steer the conversation back within the established parameters.";
