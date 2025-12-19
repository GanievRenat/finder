import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/gallery_slider_cubit.dart';

class GallerySliderBuilder extends StatelessWidget {
  const GallerySliderBuilder({
    super.key,
    required this.loading,
    required this.empty,
    required this.success,
  });

  final WidgetBuilder loading;
  final WidgetBuilder empty;
  final ValueWidgetBuilder<SliderData> success;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GallerySliderCubit, GallerySliderState>(
      bloc: context.read<GallerySliderCubit>(),
      builder: (context, state) {
        return state.when(
          loading: () => loading(context),
          empty: () => empty(context),
          data: (SliderData data) => success(context, data, this),
        );
      },
    );
  }
}
