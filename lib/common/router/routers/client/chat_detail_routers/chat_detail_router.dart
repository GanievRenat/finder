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
        onPhotoGallery: ({required modelId}) {},
        onDetailPerson: ({required person}) => DetailPersonFromChatRoute(
          personJson: person.toJson(),
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
        onPayWall: () {},
        showControlButton: false,
      ),
    );
  }
}
