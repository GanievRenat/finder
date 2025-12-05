import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionPackage extends Equatable {
  final Package package;
  final String name;
  final String discountInfo;
  final String labelPrice;

  const SubscriptionPackage({
    required this.package,
    required this.name,
    required this.discountInfo,
    required this.labelPrice,
  });

  @override
  List<Object?> get props => [package, name, discountInfo, labelPrice];
}
