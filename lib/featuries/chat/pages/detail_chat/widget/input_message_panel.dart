import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/featuries/chat/state/chat_cubit.dart';
import 'package:flutter/material.dart';

class InputMessagePanel extends StatelessWidget {
  InputMessagePanel({super.key, required this.modelId});

  final String modelId;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.of(context).color.neutralLightLightest,
      padding: EdgeInsets.only(left: 0, top: 16, right: 16, bottom: 16),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.of(context).color.neutralLightLight,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppTheme.of(context).color.primary,
                      ),
                    ),
                    onPressed: () {
                      getIt<ChatCubit>().sendMessage(
                        modelId: modelId,
                        message: _textEditingController.text,
                      );
                    },
                    icon: Icon(
                      Icons.send,
                      color: AppTheme.of(context).color.neutralLightLightest,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
