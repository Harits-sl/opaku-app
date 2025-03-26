import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:opaku_app/core/shared/theme.dart';

import 'package:opaku_app/data/model/product.dart';
import 'package:opaku_app/utils/routes/go.dart';
import 'package:opaku_app/utils/routes/route.dart';

class ItemNewDrop extends StatelessWidget {
  final Product product;

  const ItemNewDrop({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () async {
          Go.to(
            context: context,
            path: RouteName.detail,
            arguments: product.id,
          );
          await FirebaseAnalytics.instance.logEvent(
            name: "new_drop",
            parameters: {
              "name": product.name,
              "category": product.category,
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.imageUrl,
                width: 145,
                height: 130,
                fit: BoxFit.fill,
              ),
            ),
            Text(product.name),
            Text(
              product.category,
              style: grayTextStyle.copyWith(fontWeight: light, fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text('Rp ${product.price}'),
          ],
        ),
      ),
    );
  }
}
