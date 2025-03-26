import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:opaku_app/data/model/product.dart';
import 'package:opaku_app/firebase_options.dart';
import 'package:opaku_app/pages/checkout_page.dart';
import 'package:opaku_app/pages/detail_page.dart';
import 'package:opaku_app/pages/home_page.dart';
import 'package:opaku_app/pages/login_page.dart';
import 'package:opaku_app/pages/sign_up_page.dart';
import 'package:opaku_app/utils/routes/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SignUpPage(),
        RouteName.signUp: (context) => const SignUpPage(),
        RouteName.login: (context) => const LoginPage(),
        RouteName.home: (context) => const HomePage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case RouteName.detail:
            final String id = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => DetailPage(id: id),
              settings: settings,
            );
          case RouteName.payment:
            final Product product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (_) => PaymentPage(product: product),
              settings: settings,
            );

          default:
        }
        // Other values need to be implemented if we
        // add them. The assertion here will help remind
        // us of that higher up in the call stack, since
        // this assertion would otherwise fire somewhere
        // in the framework.
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
