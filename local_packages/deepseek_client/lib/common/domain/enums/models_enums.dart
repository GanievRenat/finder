enum ModelsEnums {
  chat('deepseek-chat'),
  reasoner('deepseek-reasoner');

  const ModelsEnums(this.displayName);
  final String displayName;

  @override
  String toString() => displayName;
}
