import 'package:flutter/material.dart';

import '../widgets/fragments/paywall_data_fragment.dart';
import '../widgets/fragments/paywall_error_fragment.dart';
import '../widgets/fragments/paywall_loader_fragment.dart';
import '../widgets/paywall_builder.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PayWallBuilder(
      init: (context) => PaywallLoaderFragment(),
      loading: (context) => PaywallLoaderFragment(),
      error: (context, value, child) =>
          PaywallErrorFragment(error: value.toString()),
      success: (context, value, child) => PaywallDataFragment(data: value),
    );
  }
}
