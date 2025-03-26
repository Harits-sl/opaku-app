import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:opaku_app/core/shared/theme.dart';
import 'package:opaku_app/data/model/product.dart';
import 'package:opaku_app/data/services/product_service.dart';
import 'package:opaku_app/widgets/icon_category.dart';
import 'package:opaku_app/widgets/item_new_drop.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getListProducts();
    getUsername();
  }

  List<Product>? listProducts = [];
  String username = '';

  Future<void> getListProducts() async {
    listProducts = await ProductService.fetchProducts();
    setState(() {});
  }

  Future<void> getUsername() async {
    username = await SessionManager().get("username");
    log('username: ${username}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(),
              const SizedBox(height: 12),
              jumbotron(),
              const SizedBox(height: 12),
              newDrop(),
              const SizedBox(height: 12),
              categories(),
            ],
          ),
        ),
      ),
    );
  }

  Widget categories() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
          ),
          const SizedBox(height: 4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconCategory(
                iconUrl: 'assets/images/ic_shirt.png',
                name: 'Baju',
              ),
              IconCategory(
                iconUrl: 'assets/images/ic_sock.png',
                name: 'Kaos Kaki',
              ),
              IconCategory(
                iconUrl: 'assets/images/ic_toy.png',
                name: 'Mainan',
              ),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            itemCount: listProducts!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 24,
              childAspectRatio: 1 / 1.7,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      listProducts![index].imageUrl,
                      width: 160,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(listProducts![index].name),
                  Text(
                    listProducts![index].category,
                    style: grayTextStyle.copyWith(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text('Rp ${listProducts![index].price}'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget newDrop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Text(
            'New Drop',
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 200,
          child: Container(
            child: listProducts != null && listProducts!.isNotEmpty
                ? ListView.builder(
                    itemCount: listProducts!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: index == 0 ? defaultMargin : 0,
                        ),
                        child: ItemNewDrop(product: listProducts![index]),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  )
                : Text('gagal memuat data'),
          ),
        ),
      ],
    );
  }

  Container jumbotron() {
    return Container(
      width: 500,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/jumbotron.png'),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, bottom: 25),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Explore Now',
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.all(defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 2, color: Colors.amber),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.person_rounded),
              ),
              const SizedBox(width: 8),
              Text(username),
            ],
          ),
        ],
      ),
    );
  }
}
