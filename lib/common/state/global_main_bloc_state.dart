import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalMainBlocState extends StatefulWidget {
  const GlobalMainBlocState({super.key, required this.child});

  final Widget child;

  @override
  State<GlobalMainBlocState> createState() => _GlobalMainBlocStateState();
}

class _GlobalMainBlocStateState extends State<GlobalMainBlocState> {
  @override
  Widget build(BuildContext context) {
    return widget.child;

    /*return MultiBlocProvider(
      providers: [
        /*BlocProvider(create: (context) => getIt<HistoryCubit>()),
        BlocProvider(create: (context) => getIt<SubscriptionStateCubit>()),
        BlocProvider(create: (context) => getIt<SelectModeCubit>()),
        BlocProvider(create: (context) => getIt<LibraryCardsCubit>()),
        BlocProvider(create: (context) => getIt<BalanceCubit>()),
        BlocProvider(create: (context) => getIt<SettingsCubit>()),
        BlocProvider(create: (context) => getIt<ShowBannerCubit>()),*/
      ],
      child: widget.child,
    );*/
  }
}
