import 'package:flirta/featuries/chat/pages/photo_gallery/gallery/state/gallery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryChatBuilder extends StatelessWidget {
  const GalleryChatBuilder({
    super.key,
    required this.init,
    required this.loading,
    required this.empty,
    required this.error,
    required this.success,
    required this.noPremium,
  });

  final WidgetBuilder init;
  final WidgetBuilder loading;
  final WidgetBuilder empty;
  final ValueWidgetBuilder error;
  final ValueWidgetBuilder<List<PhotoGroup>> success;
  final ValueWidgetBuilder<List<PhotoGroup>> noPremium;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryCubit, GalleryState>(
      bloc: context.read<GalleryCubit>(),
      builder: (context, state) {
        return state.when(
          init: () => init(context),
          loading: () => loading(context),
          error: (errorText) => error(context, errorText, this),
          empty: () => empty(context),
          data: (List<PhotoGroup> data) => success(context, data, this),
          dataIsNotPremium: (List<PhotoGroup> data) =>
              noPremium(context, data, this),
        );
      },
    );
  }
}
