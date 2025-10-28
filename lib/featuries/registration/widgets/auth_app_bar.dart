import 'package:flutter/material.dart';

import 'indicator_app_bar.dart';

class AuthAppBar extends AppBar {
  AuthAppBar({
    super.key,
    required int totalSteps,
    required int currentStep,
    required VoidCallback? onBack,
  }) : super(
         title: Padding(
           padding: const EdgeInsets.only(right: 48),
           child: IndicatorAppBar(
             totalSteps: totalSteps,
             currentStep: currentStep,
           ),
         ),
         leading: IconButton(
           onPressed: onBack,
           icon: Icon(Icons.arrow_back_ios),
         ),
       );
}
