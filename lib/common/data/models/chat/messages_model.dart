import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'messages_model.freezed.dart';
part 'messages_model.g.dart';

@freezed
abstract class MessagesModel with _$MessagesModel {
  const factory MessagesModel({
    @Default(0) int atCreated,
    @Default('') String userUid,
    @Default('') String modelId,
    @Default('') String owner,
    @Default('') String message,
    @Default('') String images,
    @Default(false) bool isRead,
  }) = _MessagesModel;

  factory MessagesModel.fromJson(Map<String, Object?> json) =>
      _$MessagesModelFromJson(json);
}

extension MessagesModelToEntites on MessagesModel {
  Messages toEntites() {
    return Messages(
      atCreated: DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch),
      owner: owner == 'you' ? Owner.you : Owner.person,
      message: message,
      imageUrls: images.isNotEmpty ? images.split(';') : [],
      isRead: isRead,
      modelId: modelId,
    );
  }
}
