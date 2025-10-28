import 'package:equatable/equatable.dart';

import 'notification/notification_settings.dart';

class Settings extends Equatable {
  final NotificationSettings notification;

  const Settings({required this.notification});

  @override
  List<Object?> get props => [notification];
}
