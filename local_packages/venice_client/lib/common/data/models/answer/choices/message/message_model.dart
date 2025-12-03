import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../domain/entities/message/message.dart';
import '../../../../../domain/enums/enums.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  const factory MessageModel({
    @Default('') String role,
    @Default('') String content,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, Object?> json) =>
      _$MessageModelFromJson(json);
}

extension MessageModelToEntites on MessageModel {
  Message toEntites() {
    return Message(
      role: role == RolesEnums.user.toString()
          ? RolesEnums.user
          : role == RolesEnums.system.toString()
          ? RolesEnums.system
          : RolesEnums.assistant,
      content: content,
    );
  }
}
