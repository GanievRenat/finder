part of '../../../client_router.dart';

@TypedGoRoute<DetailChatRoute>(
  path: DetailChatRoute.path,
  name: DetailChatRoute.name,
)
class DetailChatRoute extends GoRouteData with $DetailChatRoute {
  const DetailChatRoute({required this.modelId});

  static const path = '/detail_chats';
  static const name = '/detail_chats';

  final String modelId;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,
      child: DetailChatPage(
        modelId: modelId,
        onPhotoGallery: ({required person}) =>
            GalleryRoute(personJson: person.toJson()).push(context),
        onDetailPerson: ({required person}) => DetailPersonFromChatRoute(
          personJson: person.toJson(),
        ).push(context),
        onPayWall: () async =>
            await PawWallRoute().push<bool>(context) ?? false,
        onSliderPhoto: ({required fileName, required modelId}) =>
            GallerySliderRoute(
              fileName: fileName,
              modelId: modelId,
            ).push(context),
      ),
    );
  }
}

@TypedGoRoute<DetailPersonFromChatRoute>(
  path: DetailPersonFromChatRoute.path,
  name: DetailPersonFromChatRoute.name,
)
class DetailPersonFromChatRoute extends GoRouteData
    with $DetailPersonFromChatRoute {
  const DetailPersonFromChatRoute({required this.personJson});

  static const path = '/detail_person';
  static const name = '/detail_persons';

  final String personJson;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.slide(
      pageKey: state.pageKey,
      name: name,
      child: DetailPersonPage(
        person: Person.fromJson(json.decode(personJson)),
        onPayWall: () => PawWallRoute().push(context),
        showControlButton: false,
      ),
    );
  }
}

@TypedGoRoute<GalleryRoute>(path: GalleryRoute.path, name: GalleryRoute.name)
class GalleryRoute extends GoRouteData with $GalleryRoute {
  const GalleryRoute({required this.personJson});

  static const path = '/gallery';
  static const name = '/gallery';

  final String personJson;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,
      child: GalleryPage(
        person: Person.fromJson(json.decode(personJson)),
        onPayWall: () => PawWallRoute().push(context),
        onSliderPhoto: ({required fileName, required modelId}) =>
            GallerySliderRoute(
              fileName: fileName,
              modelId: modelId,
            ).push(context),
      ),
    );
  }
}

@TypedGoRoute<GallerySliderRoute>(
  path: GallerySliderRoute.path,
  name: GallerySliderRoute.name,
)
class GallerySliderRoute extends GoRouteData with $GallerySliderRoute {
  const GallerySliderRoute({required this.modelId, required this.fileName});

  static const path = '/gallery_slider';
  static const name = '/gallery_slider';

  final String modelId;
  final String fileName;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,
      child: GallerySliderPage(fileName: fileName, modelId: modelId),
    );
  }
}
