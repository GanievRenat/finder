enum Owner {
  you('you'),
  person('person');

  const Owner(this.displayName);
  final String displayName;

  @override
  String toString() => displayName;
}
