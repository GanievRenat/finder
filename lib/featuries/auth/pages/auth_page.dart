import 'package:flinder/common/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.onAuth});

  final VoidCallback onAuth;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Page')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Header1', style: Theme.of(context).textTheme.displayLarge),
            Text('Header2', style: Theme.of(context).textTheme.displayMedium),
            Text('Header3', style: Theme.of(context).textTheme.displaySmall),
            Text('Header4', style: Theme.of(context).textTheme.headlineMedium),
            Text('Header5', style: Theme.of(context).textTheme.headlineSmall),
            Text('bodyXL', style: Theme.of(context).textTheme.labelLarge),
            Text('bodyL', style: Theme.of(context).textTheme.bodyLarge),
            Text('bodyM', style: Theme.of(context).textTheme.bodyMedium),
            Text('bodyS', style: Theme.of(context).textTheme.bodySmall),
            Text('bodyXS', style: Theme.of(context).textTheme.labelSmall),
            Text('actionL', style: Theme.of(context).textTheme.titleLarge),
            Text('actionM', style: Theme.of(context).textTheme.titleMedium),
            Text('actionS', style: Theme.of(context).textTheme.titleSmall),
            Text('captionM', style: Theme.of(context).textTheme.labelMedium),
            MainButton(title: 'Continue', onPressed: () {}),
            MainButton(title: 'Continue', onPressed: () {}, isLoading: true),
            MainButton.small(title: 'Continue', onPressed: () {}),
            MainButton.inversion(title: 'Continue', onPressed: () {}),
            MainButton.inversion(
              title: 'Continue',
              onPressed: () {},
              isLoading: true,
            ),
            MainButton.inversionSmall(title: 'Continue', onPressed: () {}),
            MainButton.inversionSmall(
              title: 'Continue',
              onPressed: () {},
              isLoading: true,
            ),
            MainButton.red(title: 'Continue', onPressed: () {}),
            MainButton.red(
              title: 'Continue',
              onPressed: () {},
              isLoading: true,
            ),
            MainButton.redSmall(title: 'Continue', onPressed: () {}),
            MainButton.redSmall(
              title: 'Continue',
              onPressed: () {},
              isLoading: true,
            ),
            MainButton.reset(title: 'Reset', onPressed: () {}),
            BlackButton(title: 'Upgrade', onPressed: () {}),
            SecondButton(title: 'Continue', onPressed: () {}),
            SecondButton.small(title: 'Continue', onPressed: () {}),
            SecondButton.small(
              title: 'Continue',
              onPressed: () {},
              isLoading: true,
            ),
          ],
        ),
      ),
    );
  }
}
