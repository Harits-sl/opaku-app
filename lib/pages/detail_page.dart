import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:opaku_app/core/shared/theme.dart';
import 'package:opaku_app/data/model/product.dart';
import 'package:opaku_app/data/services/product_service.dart';
import 'package:opaku_app/utils/routes/go.dart';
import 'package:opaku_app/utils/routes/route.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail';
  final String id;

  const DetailPage({
    super.key,
    required this.id,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    getListProducts();
  }

  Product? product;

  Future<void> getListProducts() async {
    product = await ProductService.fetchProductByID(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: product != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBar(context),
                  Container(
                    height: MediaQuery.of(context).size.height * .35,
                    padding: const EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    child: Image.asset(
                      product!.imageUrl,
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 40, right: 14, left: 14),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(defaultMargin),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product!.category,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    product!.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Rp ${product!.price}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    product!.description,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        margin: const EdgeInsets.all(defaultMargin),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  Go.to(
                    context: context,
                    path: RouteName.payment,
                    arguments: product!,
                  );
                  await FirebaseAnalytics.instance.logEvent(
                    name: "begin_checkout",
                    parameters: {
                      'name': product!.name,
                      'category': product!.category,
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text('Checkout',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      )),
                  // child: Obx(
                  //   () => productController.isAddLoading.value
                  //       ? SizedBox(
                  //           width: 20,
                  //           height: 20,
                  //           child: CircularProgressIndicator(
                  //             color: Colors.white,
                  //             strokeWidth: 3,
                  //           ),
                  //         )
                  //       : Text(
                  //           '+ Add to Cart',
                  //           style: GoogleFonts.poppins(
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.w500,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar(context) {
    return GestureDetector(
      onTap: () => Go.back(context),
      child: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
