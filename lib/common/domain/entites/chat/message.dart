import 'package:equatable/equatable.dart';
import 'package:flirta/common/enums/owner_enums.dart';

class Messages extends Equatable {
  final Owner owner;
  final String modelId;
  final String message;
  final DateTime atCreated;
  final List<String> imageUrls;
  final bool isRead;

  const Messages({
    required this.owner,
    required this.message,
    required this.modelId,
    required this.atCreated,
    required this.imageUrls,
    required this.isRead,
  });

  @override
  List<Object?> get props => [
    owner,
    message,
    atCreated,
    imageUrls,
    isRead,
    modelId,
  ];
}
