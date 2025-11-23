import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class PersonListDataFragment extends StatelessWidget {
  const PersonListDataFragment({
    super.key,
    required this.persons,
    required this.onTap,
  });

  final List<PersonModel> persons;
  final Function(PersonModel person) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => ListTile(
        leading: !persons[index].boundariesStoreSfw
            ? Assets.images.icons.fire.svg(
                width: 40,
                colorFilter: AppTheme.of(context).color.red.filter,
              )
            : null,
        title: Text(persons[index].name),
        subtitle: Text(persons[index].modelId),
        trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.copy)),
        onTap: () => onTap(persons[index]),
      ),
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemCount: persons.length,
    );
  }
}
