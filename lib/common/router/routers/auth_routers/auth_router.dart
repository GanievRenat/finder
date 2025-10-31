part of '../../app_router.dart';

@TypedGoRoute<AuthRoute>(
  path: AuthRoute.path,
  name: AuthRoute.name,

  routes: [
    TypedGoRoute<EnterNameRoute>(
      path: EnterNameRoute.path,
      name: EnterNameRoute.name,
    ),
    TypedGoRoute<EnterAgeRoute>(
      path: EnterAgeRoute.path,
      name: EnterAgeRoute.name,
      routes: [
        TypedGoRoute<AlertDialogAgeValidateRoute>(
          path: AlertDialogAgeValidateRoute.path,
          name: AlertDialogAgeValidateRoute.name,
        ),
      ],
    ),
    TypedGoRoute<SelectGenderRoute>(
      path: SelectGenderRoute.path,
      name: SelectGenderRoute.name,
    ),
    TypedGoRoute<SelectInterestingGenderRoute>(
      path: SelectInterestingGenderRoute.path,
      name: SelectInterestingGenderRoute.name,
    ),
  ],
)
class AuthRoute extends GoRouteData with $AuthRoute {
  const AuthRoute();

  //static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  static const path = '/auth';
  static const name = '/slider';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,

      child: SliderPage(onEnterName: () => const EnterNameRoute().go(context)),
    );
  }
}

class EnterNameRoute extends GoRouteData with $EnterNameRoute {
  const EnterNameRoute();

  static const path = 'enter-name';
  static const name = 'enter-name';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      Transition.slideRightToLeft(
        pageKey: state.pageKey,
        name: name,
        child: EnterNamePage(onEnterAge: () => EnterAgeRoute().push(context)),
      );
}

class EnterAgeRoute extends GoRouteData with $EnterAgeRoute {
  const EnterAgeRoute();

  static const path = 'enter-age';
  static const name = 'enter-age';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      Transition.noAnimation(
        pageKey: state.pageKey,
        name: name,
        child: EnterAgePage(
          onSelectGender: () => const SelectGenderRoute().push(context),
          onDialogAgeValidate: () async =>
              await AlertDialogAgeValidateRoute().push<bool?>(context) ?? false,
          onTerms: () {},
        ),
      );
}

class SelectGenderRoute extends GoRouteData with $SelectGenderRoute {
  const SelectGenderRoute();

  static const path = 'select-gender';
  static const name = 'select-gender';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      Transition.noAnimation(
        pageKey: state.pageKey,
        name: name,
        child: SelectGenderPage(
          onSelectInterestingGender: () =>
              const SelectInterestingGenderRoute().push(context),
        ),
      );
}

class SelectInterestingGenderRoute extends GoRouteData
    with $SelectInterestingGenderRoute {
  const SelectInterestingGenderRoute();

  static const path = 'select-interesting-gender';
  static const name = 'select-interesting-gender';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      Transition.noAnimation(
        pageKey: state.pageKey,
        name: name,
        child: SelectInterestingGenderPage(
          onFinishRegistration: () => const HomeRoute().go(context),
        ),
      );
}

class AlertDialogAgeValidateRoute<T> extends GoRouteData
    with $AlertDialogAgeValidateRoute {
  const AlertDialogAgeValidateRoute();

  static const path = 'dialog-age-validate';
  static const name = 'dialog-age-validate';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return DialogPage<bool>(
      key: state.pageKey,
      name: name,
      dialogContent: MainDialog(
        title: LocaleKeys.auth_not_old_enough_error_title.tr(),
        message: LocaleKeys.auth_not_old_enough_error_subtitle.tr(),
        buttons: [
          AlertDialogButton(
            type: TypeAlertDialogButton.second,
            title: LocaleKeys.auth_not_old_enough_error_button_terms.tr(),
            value: true,
          ),
          AlertDialogButton(
            type: TypeAlertDialogButton.main,
            title: LocaleKeys.auth_not_old_enough_error_button_got_it.tr(),
            value: false,
          ),
        ],
      ),
    );
  }
}
