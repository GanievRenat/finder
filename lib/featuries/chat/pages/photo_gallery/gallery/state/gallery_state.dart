part of 'gallery_cubit.dart';

@freezed
class GalleryState with _$GalleryState {
  factory GalleryState.init() = _GalleryStateInit;
  factory GalleryState.loading() = _GalleryStateLoading;
  factory GalleryState.data(List<PhotoGroup> photoGroup) = _GalleryStateData;
  factory GalleryState.dataIsNotPremium(List<PhotoGroup> photoGroup) =
      _GalleryStateDataIsNotPremium;
  factory GalleryState.empty() = _GalleryStateEmpty;
  factory GalleryState.error(String errorText) = _GalleryStateError;
}
