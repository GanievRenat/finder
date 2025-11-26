import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
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
      appBar: AppBar(title: const LogoFlirta()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChatAppBar(
              imageURL:
                  'https://pg11.ru/userfiles/picfullsize/img-53415-14964303316571.jpg',
              modelName: 'Jane Cooper',
              onProfile: () {},
              onPhoto: () {},
            ),
            ChatAppBar(
              imageURL: '',
              modelName: 'Jane Cooper',
              onProfile: () {},
              onPhoto: () {},
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
              child: GenderTagsGroup(
                title: 'Preference',
                initGender: Gender.female,
                onChanged: (newGender) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 16,
                right: 16,
                bottom: 16,
              ),
              child: MainTagsGroup(
                title: 'Interests',
                tags: {
                  'Fitness',
                  'Cooking',
                  'Gamer',
                  'Travelling',
                  'Photo',
                  'Music',
                },
                initTags: {'Cooking', 'Gamer'},
                onChanged: (selectTags) {},
              ),
            ),

            AvatarModel(imageURL: ''),
            AvatarProfile(canEdit: true),
            AvatarProfile(radius: 50),
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
            GenderOptionsGroup<Gender>(
              options: [Gender.male, Gender.female, Gender.nonBinary],
              selectedOption: Gender.nonBinary,
              onChanged: (value) {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InterestedGenderOptionsGroup(
                selectedOption: Gender.nonBinary,
                onChanged: (value) {},
              ),
            ),

            ListTileItem(title: 'Restore subscription', onTap: () {}),
            AppSpacing.vertical.s4,
            ListTileItem(title: 'Term of use'),
            AppSpacing.vertical.s4,
            SwitchListTile(
              value: true,
              onChanged: (value) {},
              title: Text('Text messages'),
              subtitle: Text('Get notified when your matches message you'),
            ),
            SwitchListTile(
              value: false,
              onChanged: (value) {},
              title: Text('Text messages'),
              subtitle: Text('Get notified when your matches message you'),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NoPremiumStatus(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: PremiumStatus(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTileProfileItem(
                title: 'Name',
                subtitle: 'Sara',
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTileProfileItem(
                title: 'Gender',
                subtitle: 'Male',
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTileProfileItem(
                title: 'Age',
                subtitle: '24',
                onTap: () {},
              ),
            ),

            //
            SelectAge(
              beginAge: 18,
              endAge: 99,
              initAge: 99,
              onChange: (age) {},
            ),
          ],
        ),
      ),
    );
  }
}
