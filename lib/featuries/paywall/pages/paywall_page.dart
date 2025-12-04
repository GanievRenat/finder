import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';

import '../widgets/benefid_item.dart';
import '../widgets/product_group/product_group.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Assets.images.bgPaywallA.image(fit: BoxFit.fitHeight),
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
                      'Choose your\nsubscription plan',
                      style: AppTheme.of(context).textStyle.header1.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                    AppSpacing.vertical.s4,
                    Text(
                      "You'll get:",
                      style: AppTheme.of(context).textStyle.header3.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                    BenefidItem(text: '<b>10 swipes</b> per day'),
                    BenefidItem(text: 'Cancel your <b>last skip</b>'),
                    BenefidItem(text: '<b>Unlimited</b> photo access'),
                    AppSpacing.vertical.s4,
                    ProductGroup(),
                    AppSpacing.vertical.s1,
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "And get a 7-day free trial",
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).textStyle.bodyL.copyWith(
                          color: AppTheme.of(
                            context,
                          ).color.neutralLightLightest,
                        ),
                      ),
                    ),
                    AppSpacing.vertical.s4,
                    MainButton.inversion(title: 'Subscribe', onPressed: () {}),
                    AppSpacing.vertical.s4,
                    Align(
                      alignment: Alignment.center,
                      child: Text(
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
