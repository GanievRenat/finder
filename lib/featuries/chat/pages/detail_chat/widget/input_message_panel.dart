import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/chat/state/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputMessagePanel extends StatelessWidget {
  InputMessagePanel({super.key, required this.modelId});

  final String modelId;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.of(context).color.neutralLightLightest,
      padding: EdgeInsets.only(
        left: 0,
        top: 16,
        right: 16,
        bottom: 16 + MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              var imageSource = await ImageSourceBottomSheet().show(context);
              if (imageSource == ImageSource.camera) {
              } else if (imageSource == ImageSource.gallery) {}
            },
            icon: Icon(Icons.add),
          ),
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
                      onFieldSubmitted: (value) {
                        onFieldSubmitted();
                      },
                    ),
                  ),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppTheme.of(context).color.primary,
                      ),
                    ),
                    onPressed: () {
                      onFieldSubmitted();
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

  void onFieldSubmitted() {
    if (_textEditingController.text.trim().isNotEmpty) {
      getIt<ChatCubit>().sendMessage(
        modelId: modelId,
        message: _textEditingController.text,
      );
      _textEditingController.text = '';
    }
  }
}
