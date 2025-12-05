import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/paywall/widgets/product_group/product_group.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';

import 'package:flutter/material.dart';

import '../../state/paywall_cubit.dart';
import '../benefid_item.dart';

class PaywallDataFragment extends StatefulWidget {
  const PaywallDataFragment({super.key, required this.data});
  final PayWallData data;

  @override
  State<PaywallDataFragment> createState() => _PaywallDataFragmentState();
}

class _PaywallDataFragmentState extends State<PaywallDataFragment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: BackGroundImage(payWallVersion: widget.data.version),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 16,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.data.title,
                      style: AppTheme.of(context).textStyle.header1.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                    AppSpacing.vertical.s4,
                    Benifits(value: widget.data.benefits),
                    AppSpacing.vertical.s4,
                    ProductGroup(
                      version: widget.data.version,
                      subscriptionPackages: widget.data.subscriptions,
                      onSelect: (packages) {},
                    ),
                    AppSpacing.vertical.s1,
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.data.trialText,
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).textStyle.bodyL.copyWith(
                          color: AppTheme.of(
                            context,
                          ).color.neutralLightLightest,
                        ),
                      ),
                    ),
                    AppSpacing.vertical.s4,
                    MainButton.inversion(
                      title: widget.data.buttonTitle,
                      onPressed: () {},
                    ),
                    AppSpacing.vertical.s4,
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        // TODO: ВСТАВИТЬ НОРМАЛЬНЫЕ ТЕРМСЫ
                        "By continuing, you agree to our Terms and Conditions and the Privacy Policy.",
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).textStyle.bodyM.copyWith(
                          color: AppTheme.of(
                            context,
                          ).color.neutralLightLightest,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: MediaQuery.of(context).padding.top + 16,
            child: GoToBackButton(),
          ),
        ],
      ),
    );
  }
}

class BackGroundImage extends StatelessWidget {
  const BackGroundImage({super.key, required this.payWallVersion});

  final PayWallVersion payWallVersion;

  @override
  Widget build(BuildContext context) {
    return (payWallVersion == PayWallVersion.b)
        ? Assets.images.bgPaywallB.image(fit: BoxFit.fitHeight)
        : Assets.images.bgPaywallA.image(fit: BoxFit.fitHeight);
  }
}

class Benifits extends StatelessWidget {
  const Benifits({super.key, required this.value});

  final List<String> value;

  @override
  Widget build(BuildContext context) {
    List<BenefidItem> b = value.map((e) => BenefidItem(text: e)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.paywall_subtitle.tr(),
          style: AppTheme.of(context).textStyle.header3.copyWith(
            color: AppTheme.of(context).color.neutralLightLightest,
          ),
        ),
        ...b,
      ],
    );
  }
}
