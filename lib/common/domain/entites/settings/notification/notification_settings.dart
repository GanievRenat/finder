import 'package:equatable/equatable.dart';

class NotificationSettings extends Equatable {
  final bool message;

  const NotificationSettings({this.message = true});

  NotificationSettings copyWith({bool? message}) {
    return NotificationSettings(message: message ?? this.message);
  }

  @override
  List<Object?> get props => [message];
}
