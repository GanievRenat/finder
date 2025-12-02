import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/repository/admin/bodies/auth_by_admin_body.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class AuthAdminPage extends StatefulWidget {
  const AuthAdminPage({super.key, required this.onHome});

  final Function onHome;

  @override
  State<AuthAdminPage> createState() => _AuthAdminPageState();
}

class _AuthAdminPageState extends State<AuthAdminPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoadingAuth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: AppTheme.of(context).color.neutralLightLight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LogoFlirta(),
                Text(
                  LocaleKeys.admin_auth_title.tr(),
                  textAlign: TextAlign.center,
                  style: AppTheme.of(context).textStyle.bodyXL,
                ),
                AppSpacing.vertical.s8,
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width > 800
                        ? MediaQuery.of(context).size.width * 0.4
                        : MediaQuery.of(context).size.width > 600
                        ? MediaQuery.of(context).size.width * 0.5
                        : MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            label: Text(
                              LocaleKeys.properties_labels_email.tr(),
                            ),
                          ),
                          validator: (value) {
                            String email = value ?? '';
                            if (email.trim().isEmpty) {
                              return LocaleKeys
                                  .admin_auth_error_enter_your_email
                                  .tr();
                            }
                            String pattern =
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+";

                            bool emailValid = RegExp(pattern).hasMatch(email);

                            if (!emailValid) {
                              return LocaleKeys
                                  .admin_auth_error_enter_correct_email
                                  .tr();
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            label: Text(
                              LocaleKeys.properties_labels_password.tr(),
                            ),
                          ),
                          validator: (value) {
                            String password = value ?? '';
                            if (password.trim().isEmpty) {
                              return LocaleKeys
                                  .admin_auth_error_enter_your_password
                                  .tr();
                            }
                            if (password.length < 6) {
                              return LocaleKeys
                                  .admin_auth_error_enter_correct_password
                                  .tr();
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) => onSubmit(context),
                          obscureText: true,
                          obscuringCharacter: '*',
                        ),
                        AppSpacing.vertical.s8,
                        MainButton(
                          title: LocaleKeys.admin_auth_login_button_title.tr(),
                          isLoading: isLoadingAuth,
                          onPressed: () => onSubmit(context),
                        ),
                        /*AppSpacing.vertical.s8,
                        TextButton(
                          child: Text('I forgot my password'),
                          onPressed: () {},
                        ),*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoadingAuth = true;
      });

      var result = await getIt<AuthByAdmin>().call(
        AuthByAdminBody(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
      setState(() {
        isLoadingAuth = false;
      });
      if (result.isRight) {
        widget.onHome();
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text(
                LocaleKeys.admin_auth_error_main_error_text.tr(),
                style: AppTheme.of(context).textStyle.bodyXL.copyWith(
                  color: AppTheme.of(context).color.error,
                ),
              ),
              actions: [
                MainButton.small(
                  title: LocaleKeys.properties_buttons_ok.tr(),
                  onPressed: () =>
                      ScaffoldMessenger.of(context).clearMaterialBanners(),
                ),
              ],
            ),
          );
        }
      }
    }
  }
}
