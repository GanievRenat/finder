enum RolesEnums {
  user('user'),
  system('system'),
  assistant('assistant');

  const RolesEnums(this.displayName);
  final String displayName;

  @override
  String toString() => displayName;
}
