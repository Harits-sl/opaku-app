import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:opaku_app/core/shared/theme.dart';

class IconCategory extends StatelessWidget {
  final String iconUrl;
  final String name;

  const IconCategory({
    super.key,
    required this.iconUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await FirebaseAnalytics.instance
            .logEvent(name: "category_widget", parameters: {
          'name': name,
        });
      },
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: primaryColor,
            ),
            child: Image.asset(
              iconUrl,
            ),
          ),
          const SizedBox(height: 4),
          Text(name),
        ],
      ),
    );
  }
}
