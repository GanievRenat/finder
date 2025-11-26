import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'messages_model.freezed.dart';
part 'messages_model.g.dart';

@freezed
abstract class MessagesModel with _$MessagesModel {
  const factory MessagesModel({
    @Default(0) @JsonKey(name: 'atCreated') int atCreated,
    @Default('') @JsonKey(name: 'userUid') String userUid,
    @Default('') @JsonKey(name: 'modelId') String modelId,
    @Default('') @JsonKey(name: 'owner') String owner,
    @Default('') @JsonKey(name: 'message') String message,
    @Default('') @JsonKey(name: 'images') String images,
    @Default(false) @JsonKey(name: 'isRead') bool isRead,
  }) = _MessagesModel;

  factory MessagesModel.fromJson(Map<String, Object?> json) =>
      _$MessagesModelFromJson(json);
}

extension MessagesModelToEntites on MessagesModel {
  Messages toEntites() {
    return Messages(
      atCreated: DateTime.fromMillisecondsSinceEpoch(atCreated),
      owner: owner == 'you' ? Owner.you : Owner.person,
      message: message,
      imageUrls: images.isNotEmpty ? images.split(';') : [],
      isRead: isRead,
      modelId: modelId,
    );
  }
}
