import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/ui/theme/theme.dart';
//import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/chat/state/chat_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class InputMessagePanel extends StatelessWidget {
  InputMessagePanel({super.key, required this.modelId}) : isLoading = false;

  InputMessagePanel.loading({super.key}) : isLoading = true, modelId = '';

  final String modelId;
  final bool isLoading;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.of(context).color.neutralLightLightest,
      padding: EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
        bottom: 16 + MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        children: [
          /*if (!kIsWeb)
            IconButton(
              onPressed: () async {
                var imageSource = await ImageSourceBottomSheet().show(context);
                if (imageSource == ImageSource.camera) {
                } else if (imageSource == ImageSource.gallery) {}
              },
              icon: Icon(Icons.add),
            ),*/
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
                      focusNode: _focusNode,
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
      if (kIsWeb) {
        _focusNode.requestFocus();
      }
    }
  }
}

class LoadingInputMessage extends StatelessWidget {
  const LoadingInputMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: AppTheme.of(context).color.neutralLightMedium,
        highlightColor: AppTheme.of(context).color.neutralLightLightest,
        duration: Duration(seconds: 2),
      ),
      enabled: true,
      ignoreContainers: false,
      child: Container(
        color: AppTheme.of(context).color.neutralLightLightest,
        padding: EdgeInsets.only(
          left: 16,
          top: 16,
          right: 16,
          bottom: 16 + MediaQuery.of(context).padding.bottom,
        ),
        child: Row(
          children: [
            /*IconButton(
              onPressed: () async {
                var imageSource = await ImageSourceBottomSheet().show(context);
                if (imageSource == ImageSource.camera) {
                } else if (imageSource == ImageSource.gallery) {}
              },
              icon: Icon(Icons.add),
            ),*/
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
                        enabled: false,
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
                        onFieldSubmitted: (value) {},
                      ),
                    ),
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppTheme.of(context).color.primary,
                        ),
                      ),
                      onPressed: () {},
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
      ),
    );
  }
}
