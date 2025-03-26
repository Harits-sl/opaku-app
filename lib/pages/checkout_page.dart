// ignore_for_file: avoid_print

import 'dart:io';
import 'package:checkout_screen_ui/checkout_ui.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:opaku_app/data/model/product.dart';
import 'package:opaku_app/utils/routes/go.dart';

class PaymentPage extends StatefulWidget {
  final Product product;

  static const String routeName = '/checkout';

  const PaymentPage({super.key, required this.product});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  Future<void> _nativePayClicked(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment Success with Google Pay')));

    await FirebaseAnalytics.instance.logEvent(
      name: "success_payment",
      parameters: {
        'name': widget.product.name,
        'category': widget.product.category,
        'payment_method': 'google payment',
      },
    );

    Go.to(context: context, path: '/home');
  }

  Future<void> _cashPayClicked(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment Success with cash')));

    await FirebaseAnalytics.instance.logEvent(
      name: "success_payment",
      parameters: {
        'name': widget.product.name,
        'category': widget.product.category,
        'payment_method': 'cash payment',
      },
    );

    Go.to(context: context, path: '/home');
  }

  Future<void> _creditPayClicked(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment Success with credit card')));

    await FirebaseAnalytics.instance.logEvent(
      name: "success_payment",
      parameters: {
        'name': widget.product.name,
        'category': widget.product.category,
        'payment_method': 'credit card payment',
      },
    );

    Go.to(context: context, path: '/home');
  }

  Future<void> _getUsername() async {
    _username = await SessionManager().get("username");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<CardPayButtonState> _payBtnKey =
        GlobalKey<CardPayButtonState>();

    final List<PriceItem> _priceItems = [
      PriceItem(
        name: widget.product.name,
        quantity: 1,
        itemCostCents: widget.product.price,
      ),
    ];

    String _payToName = _username;

    final _isApple = kIsWeb ? false : Platform.isIOS;

    Function? _onBack = Navigator.of(context).canPop()
        ? () => Navigator.of(context).pop()
        : null;

    return Scaffold(
      appBar: null,
      body: CheckoutPage(
        data: CheckoutData(
          priceItems: _priceItems,
          payToName: _payToName,
          displayNativePay: !kIsWeb,
          onNativePay: (checkoutResults) => _nativePayClicked(context),
          onCashPay: (checkoutResults) => _cashPayClicked(context),
          isApple: _isApple,
          onCardPay: (paymentInfo, checkoutResults) =>
              _creditPayClicked(context),
          onBack: _onBack,
          payBtnKey: _payBtnKey,
          displayTestData: true,
        ),
      ),
    );
  }
}
