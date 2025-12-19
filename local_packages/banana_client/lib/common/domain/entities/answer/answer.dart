import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Answer extends Equatable {
  final Uint8List imageByte;

  const Answer({required this.imageByte});

  @override
  List<Object?> get props => [imageByte];
}
