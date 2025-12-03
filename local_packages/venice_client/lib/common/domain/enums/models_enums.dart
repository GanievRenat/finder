enum ModelsEnums {
  chat('venice-uncensored'),
  reasoner('venice-reasoner');

  const ModelsEnums(this.displayName);
  final String displayName;

  @override
  String toString() => displayName;
}
