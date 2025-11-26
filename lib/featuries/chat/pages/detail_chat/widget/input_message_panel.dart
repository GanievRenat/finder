import 'dart:math' as math;

import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/featuries/chat/pages/detail_chat/state/detail_chat_cubit.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputMessagePanel extends StatelessWidget {
  const InputMessagePanel({super.key});

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
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppTheme.of(context).color.primary,
                      ),
                    ),
                    onPressed: () {
                      context.read<DetailChatCubit>().sendMessage(
                        message: 'Hello!',
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
