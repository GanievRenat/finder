enum AIAgentChat {
  none('none'), //
  deepseek('deepseek'), // Чат с SFW (безопасный)
  venice('venice'); // Чат без SFW (горячие)

  const AIAgentChat(this.displayName);
  final String displayName;

  @override
  String toString() => displayName;
}

enum AIAgentImage {
  none('none'), //
  banana('banana'), // Фото с SFW (безопасно)
  spicyapi('spicyapi'); // Фото без SFW (горячиеы)

  const AIAgentImage(this.displayName);
  final String displayName;

  @override
  String toString() => displayName;
}

enum AIAgentResultAnswer {
  success('success'), //
  photo('photo'), //
  error('error'); //

  const AIAgentResultAnswer(this.displayName);
  final String displayName;

  @override
  String toString() => displayName;
}
