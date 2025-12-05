import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/buttons/close_button.dart';
import 'package:flirta/common/ui/widgets/buttons/main_button.dart';
import 'package:flirta/featuries/paywall/widgets/benefid_item.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../product_group/product_item.dart';

class PaywallLoaderFragment extends StatelessWidget {
  const PaywallLoaderFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Skeletonizer(
        effect: ShimmerEffect(
          baseColor: AppTheme.of(context).color.neutralLightMedium,
          highlightColor: AppTheme.of(context).color.neutralLightLightest,
          duration: Duration(seconds: 2),
        ),
        enabled: true,
        ignoreContainers: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: AppTheme.of(context).color.neutralLightLight,
              ),
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
                          color: AppTheme.of(
                            context,
                          ).color.neutralLightLightest,
                        ),
                      ),
                      AppSpacing.vertical.s4,
                      Text(
                        "You'll get:",
                        style: AppTheme.of(context).textStyle.header3.copyWith(
                          color: AppTheme.of(
                            context,
                          ).color.neutralLightLightest,
                        ),
                      ),
                      BenefidItem(text: '<b>10 swipes</b> per day'),
                      BenefidItem(text: 'Cancel your <b>last skip</b>'),
                      BenefidItem(text: '<b>Unlimited</b> photo access'),
                      AppSpacing.vertical.s4,
                      ProductItem<int>(
                        version: PayWallVersion.a,
                        value: 1,
                        onTap: (value) {},
                        isSelect: false,
                        title: 'Yearly',
                        subtitle: '-66% discount',
                        price: '\$99.99',
                        priceLabel: 'every year',
                      ),
                      AppSpacing.vertical.s3,
                      ProductItem<int>(
                        version: PayWallVersion.a,
                        value: 2,
                        onTap: (value) {},
                        isSelect: false,
                        title: 'Monthly',
                        subtitle: '-53% discount',
                        price: '\$29.99',
                        priceLabel: 'every month',
                      ),
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
                      MainButton.inversion(title: 'Subscribe'),
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
      ),
    );
  }
}
