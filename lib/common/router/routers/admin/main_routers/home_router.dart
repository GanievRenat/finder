part of '../../../admin_router.dart';

class PersonsAdminRoute extends GoRouteData with $PersonsAdminRoute {
  const PersonsAdminRoute();

  static const path = '/models';
  static const name = '/models';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,
      child: PersonsAdminPage(
        onCreateNewModel: () => PersonDetailAdminRoute().push(context),
        onDetailModel: (person) => PersonDetailAdminRoute(
          personModel: json.encode(person.toJson()),
        ).push(context),
      ),
    );
  }
}

class SettingsAdminRoute extends GoRouteData with $SettingsAdminRoute {
  const SettingsAdminRoute();

  static const path = '/settings';
  static const name = '/settings';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,
      child: SettingsAdminPage(),
    );
  }
}

class PersonDetailAdminRoute extends GoRouteData with $PersonDetailAdminRoute {
  const PersonDetailAdminRoute({this.personModel});

  final String? personModel;

  static const path = 'detail';
  static const name = 'detail';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,
      child: PersonDetailAdminPage(
        personModel: personModel != null
            ? PersonModel.fromJson(json.decode(personModel!)!)
            : null,
        onDetailChat: ({required String modelId}) async =>
            await DetailChatAdminRoute(modelId: modelId).push(context) ?? false,
        onDeletePerson: () async =>
            await AlertDialogDeleteModelRoute().push<bool?>(context) ?? false,
      ),
    );
  }
}

class DetailChatAdminRoute extends GoRouteData with $DetailChatAdminRoute {
  const DetailChatAdminRoute({required this.modelId});

  static const path = 'detail_chats';
  static const name = 'detail_chats';

  final String modelId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return DialogPage<bool>(
      key: state.pageKey,
      name: name,
      dialogContent: DetailChatPage(
        modelId: modelId,
        onPhotoGallery: ({required person}) {},
        onDetailPerson: ({required person}) {},
        onSliderPhoto: ({required fileName, required modelId}) {},
        onPayWall: () async => false,
      ),
    );
  }
}

class AlertDialogDeleteModelRoute extends GoRouteData
    with $AlertDialogDeleteModelRoute {
  const AlertDialogDeleteModelRoute();

  static const path = 'dialog-delete-model';
  static const name = 'dialog-delete-model';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return DialogPage<bool>(
      key: state.pageKey,
      name: name,
      dialogContent: MainDialog(
        title: 'Удалить?',
        message: 'Вы действительно хотите удалить модель?',
        buttons: [
          AlertDialogButton<bool>(
            type: TypeAlertDialogButton.red,
            title: LocaleKeys.properties_dialogs_delete_account_button_delete
                .tr(),
            value: true,
          ),
          AlertDialogButton<bool>(
            type: TypeAlertDialogButton.main,
            title: LocaleKeys.properties_dialogs_delete_account_button_cancel
                .tr(),
            value: false,
          ),
        ],
      ),
    );
  }
}
