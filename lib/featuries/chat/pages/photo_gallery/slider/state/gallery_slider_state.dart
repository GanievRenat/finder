part of 'gallery_slider_cubit.dart';

@freezed
class GallerySliderState with _$GallerySliderState {
  factory GallerySliderState.loading() = _GallerySliderStateLoading;
  factory GallerySliderState.data(SliderData data) = _GallerySliderStateData;

  factory GallerySliderState.empty() = _GallerySliderStateEmpty;
}
