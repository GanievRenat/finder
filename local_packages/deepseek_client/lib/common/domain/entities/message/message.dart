import 'package:deepseek_client/common/domain/enums/roles_enums.dart';
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final RolesEnums role;
  final String content;

  const Message({required this.role, required this.content});

  Map<String, String> toMap() => {'role': role.toString(), 'content': content};

  @override
  List<Object?> get props => [role, content];
}
