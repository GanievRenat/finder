import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flutter/material.dart';

import 'product_item.dart';

class ProductGroup extends StatefulWidget {
  const ProductGroup({
    super.key,
    required this.version,
    required this.subscriptionPackages,
    required this.onSelect,
  });

  final PayWallVersion version;
  final List<SubscriptionPackage> subscriptionPackages;
  final Function(SubscriptionPackage packages) onSelect;

  @override
  State<ProductGroup> createState() => _ProductGroupState();
}

class _ProductGroupState extends State<ProductGroup> {
  SubscriptionPackage? valueGroup;

  @override
  void initState() {
    super.initState();
    if (widget.subscriptionPackages.isNotEmpty) {
      valueGroup = widget.subscriptionPackages.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ProductItem<SubscriptionPackage>> listItems = widget
        .subscriptionPackages
        .map(
          (e) => ProductItem<SubscriptionPackage>(
            version: widget.version,
            value: e,
            onTap: (value) {
              setState(() {
                valueGroup = value;
              });
              widget.onSelect(value);
            },
            isSelect: valueGroup == e,
            title: e.name,
            subtitle: e.discountInfo,
            price: e.package.storeProduct.priceString,
            priceLabel: e.labelPrice,
          ),
        )
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: listItems
          .map((e) => Padding(padding: EdgeInsets.only(bottom: 8), child: e))
          .toList(),
    );
  }
}
