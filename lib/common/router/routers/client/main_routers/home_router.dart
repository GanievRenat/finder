part of '../../../client_router.dart';

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  static const path = '/home';
  static const name = '/home';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,
      child: DatingPage(
        onFilter: () => const FiltersRoute().push(context),
        onMatch: ({required Person person}) async =>
            await MatchRoute(personJson: person.toJson()).push<bool>(context) ??
            false,
        onDetailPerson: ({required Person person}) async =>
            await DetailPersonRoute(
              personJson: person.toJson(),
            ).push<ActionCallBackPersonDetailEnums>(context) ??
            ActionCallBackPersonDetailEnums.none,
        onPayWall: () => PawWallRoute().push(context),
        onDetailChat: ({required String modelId}) async =>
            await DetailChatRoute(modelId: modelId).push(context) ?? false,
      ),
    );
  }
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  static const path = '/profile';
  static const name = '/profile';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,
      child: ProfilePage(
        onEditProfile: () => const EditProfileRoute().push(context),
        onNotificationSettings: () =>
            const NotificationSettingsRoute().push(context),
        onPayWall: () => PawWallRoute().push(context),
      ),
    );
  }
}

class ChatsRoute extends GoRouteData with $ChatsRoute {
  const ChatsRoute();

  static const path = '/chats';
  static const name = '/chats';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,
      child: ListChatPage(
        onDetailChat: ({required String modelId}) async =>
            await DetailChatRoute(modelId: modelId).push(context) ?? false,
        onDating: () => HomeRoute().go(context),
      ),
    );
  }
}

class FiltersRoute extends GoRouteData with $FiltersRoute {
  const FiltersRoute();

  static const path = 'filters';
  static const name = 'filters';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.slide(
      pageKey: state.pageKey,
      name: name,
      child: FilterPage(),
    );
  }
}

class DetailPersonRoute extends GoRouteData with $DetailPersonRoute {
  const DetailPersonRoute({required this.personJson});

  static const path = 'detail_person';
  static const name = 'detail_person';

  final String personJson;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.slide(
      pageKey: state.pageKey,
      name: name,
      child: DetailPersonPage(
        person: Person.fromJson(json.decode(personJson)),
        onPayWall: () => PawWallRoute().push(context),
      ),
    );
  }
}

class EditProfileRoute extends GoRouteData with $EditProfileRoute {
  const EditProfileRoute();

  static const path = 'edit-profile';
  static const name = 'edit-profile';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.slide(
      pageKey: state.pageKey,
      name: name,
      child: EditProfilePage(
        onRegistration: () => AuthRoute().go(context),
        onAgeEdit: (initAge) =>
            EditAgeProfileRoute(initAge: initAge).push(context),
        onNameEdit: (initName) =>
            EditNameProfileRoute(initName: initName).push(context),
        onGenderEdit: (initGenderIndex) => EditGenderProfileRoute(
          initGenderIndex: initGenderIndex,
        ).push(context),
        onDialogDeleteProfile: () async =>
            await AlertDialogDeleteProfileRoute().push<bool?>(context) ?? false,
      ),
    );
  }
}

class EditAgeProfileRoute extends GoRouteData with $EditAgeProfileRoute {
  const EditAgeProfileRoute({required this.initAge});

  static const path = 'age-edit-profile';
  static const name = 'age-edit-profile';

  final int initAge;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalBottomSheetPage(
      key: state.pageKey,
      name: name,
      title: LocaleKeys.auth_how_old_are_you_title.tr(),
      subtitle: LocaleKeys.auth_how_old_are_you_subtitle.tr(),
      child: AgeEditWidget(
        initAge: initAge,
        onComplited: () {
          context.pop();
        },
      ),
    );
  }
}

class EditGenderProfileRoute extends GoRouteData with $EditGenderProfileRoute {
  const EditGenderProfileRoute({required this.initGenderIndex});

  static const path = 'gender-edit-profile';
  static const name = 'gender-edit-profile';

  final int initGenderIndex;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalBottomSheetPage(
      key: state.pageKey,
      name: name,
      title: LocaleKeys.auth_how_old_are_you_title.tr(),
      subtitle: LocaleKeys.auth_how_old_are_you_subtitle.tr(),
      isScroll: true,
      child: GenderEditWidget(
        initGender: Gender.values[initGenderIndex],
        onComplited: () {
          context.pop();
        },
      ),
    );
  }
}

class EditNameProfileRoute extends GoRouteData with $EditNameProfileRoute {
  const EditNameProfileRoute({required this.initName});

  static const path = 'name-edit-profile';
  static const name = 'name-edit-profile';

  final String initName;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalBottomSheetPage(
      key: state.pageKey,
      name: name,
      title: LocaleKeys.auth_how_old_are_you_title.tr(),
      subtitle: LocaleKeys.auth_how_old_are_you_subtitle.tr(),
      child: NameEditWidget(
        initName: initName,
        onComplited: () {
          context.pop();
        },
      ),
    );
  }
}

class NotificationSettingsRoute extends GoRouteData
    with $NotificationSettingsRoute {
  const NotificationSettingsRoute();

  static const path = 'notification-settings';
  static const name = 'notification-settings';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.slide(
      pageKey: state.pageKey,
      name: name,
      child: NotificationSettingsPage(),
    );
  }
}

class AlertDialogDeleteProfileRoute extends GoRouteData
    with $AlertDialogDeleteProfileRoute {
  const AlertDialogDeleteProfileRoute();

  static const path = 'dialog-delete-profile';
  static const name = 'dialog-delete-profile';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return DialogPage<bool>(
      key: state.pageKey,
      name: name,
      dialogContent: MainDialog(
        title: LocaleKeys.properties_dialogs_delete_account_title.tr(),
        message: LocaleKeys.properties_dialogs_delete_account_message.tr(),
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
