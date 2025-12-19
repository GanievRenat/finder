import 'package:equatable/equatable.dart';

enum Status { completed, failed, processing, cancelled }

class Answer extends Equatable {
  final String requestId;
  final Status status;
  final String downloadUrl;

  const Answer({
    required this.requestId,
    required this.status,
    required this.downloadUrl,
  });

  @override
  List<Object?> get props => [requestId, status, downloadUrl];
}
