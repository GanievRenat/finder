import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flutter/material.dart';

import 'product_item.dart';

class ProductGroup extends StatefulWidget {
  const ProductGroup({super.key});

  @override
  State<ProductGroup> createState() => _ProductGroupState();
}

class _ProductGroupState extends State<ProductGroup> {
  int valueGroup = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProductItem<int>(
          value: 1,
          onTap: (value) {
            setState(() {
              valueGroup = value;
            });
          },
          isSelect: valueGroup == 1,
          title: 'Yearly',
          subtitle: '-66% discount',
          price: '\$99.99',
          priceLabel: 'every year',
        ),
        AppSpacing.vertical.s3,
        ProductItem<int>(
          value: 2,
          onTap: (value) {
            setState(() {
              valueGroup = value;
            });
          },
          isSelect: valueGroup == 2,
          title: 'Monthly',
          subtitle: '-53% discount',
          price: '\$29.99',
          priceLabel: 'every month',
        ),
      ],
    );
  }
}
