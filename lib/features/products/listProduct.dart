import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../store/api/api.dart';
import '../../store/models/luxuryProduct.dart';
import '../../store/provider/CartProvider.dart';
import 'cart.dart';
import 'detailProductScreen.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  bool isLoading = true;
  CollectionReference luxuryProductRef =
      FirebaseFirestore.instance.collection('luxuryProduct');
  List<LuxuryProduct> listLuxuryProduct = [];
  List<LuxuryProduct> listProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  Future _loadData() async {
    var cart = Provider.of<CartProvider>(context, listen: false);
    listProducts = await getCartListFB();
    listLuxuryProduct = await getLuxuryListFB();
    cart.changeListCart(listProducts);
    cart.changeCounterCart(listProducts.length);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
        builder: (BuildContext context, cartProvider, widget) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              "Products",
              style: TextStyle(color: primaryDarkColor),
            ),
            centerTitle: true,
            // leading: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     IconButton(
            //       icon: Icon(Icons.arrow_back_ios, color: primaryDarkColor),
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //       },
            //     ),
            //   ],
            // ),
            actions: [
              Badge(
                badgeContent: Text(
                  cartProvider.getCounter().toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                position: const BadgePosition(start: 30, bottom: 28),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    color: primaryDarkColor,
                    size: 25,
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
            ],
          ),
          body: (isLoading)
              ? SpinKitFadingCircle(
                  color: primaryOrangeColor,
                  size: 50.0,
                  duration: const Duration(milliseconds: 2000),
                )
              : _renderRecentOrderList());
    });
  }

  _renderRecentOrderList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _renderTitle("All products"),
                  ],
                ),
                _renderListItemProduct(listLuxuryProduct),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _renderTitle(title) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 28,
          color: primaryDarkColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _renderListItemProduct(List<LuxuryProduct> luxuryProducts) {
    List<Widget> list = [];
    for (var i = 0; i < luxuryProducts.length; i++) {
      list.add(_renderProductItem(luxuryProducts[i]));
    }
    return Column(children: list);
  }

  _renderProductItem(LuxuryProduct luxuryProduct) {
    return InkWell(
      onTap: () {
        _gotoProductDetailScreen(luxuryProduct, context);
      },
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: primaryLightColor,
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //       blurRadius: 5,
          //       spreadRadius: 3,
          //       color: Colors.black.withOpacity(0.2),
          //       offset: const Offset(1, 1)),
          //   const BoxShadow(
          //     color: Colors.white,
          //     offset: Offset(0.0, 0.0),
          //     blurRadius: 0.0,
          //     spreadRadius: 0.0,
          //   ),
          // ],
        ),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 100,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(luxuryProduct.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10, right: 4.0, left: 10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        luxuryProduct.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryDarkColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _renderNumberStar(luxuryProduct.rateStar),
                    Expanded(child: Container()),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "\$${luxuryProduct.currentPrice.toString()}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xffE5AA63),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "\$${luxuryProduct.lastPrice.toString()}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                // print(luxuryProduct.isLiked);
                                setState(() {
                                  if (luxuryProduct.isLiked) {
                                    luxuryProduct.isLiked = false;
                                    updateOneField(
                                        id: luxuryProduct.id,
                                        dataUpdate: {
                                          'isLiked': false,
                                        });
                                  } else {
                                    luxuryProduct.isLiked = true;
                                    updateOneField(
                                        id: luxuryProduct.id,
                                        dataUpdate: {
                                          'isLiked': true,
                                        });
                                  }
                                  // (luxuryProduct.isLiked)
                                  //     ? (luxuryProduct.isLiked = false,)
                                  //     : (luxuryProduct.isLiked = true);
                                  // (luxuryProduct.isLiked)
                                  //     ? (updateOneField(
                                  //         id: luxuryProduct.id,
                                  //         dataUpdate: {
                                  //             'isLiked': false,
                                  //           }))
                                  //     : (updateOneField(
                                  //         id: luxuryProduct.id,
                                  //         dataUpdate: {
                                  //             'isLiked': true,
                                  //           }));
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryDarkerLightColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: (luxuryProduct.isLiked)
                                    ? FaIcon(FontAwesomeIcons.solidHeart,
                                        color: Colors.red[800], size: 20)
                                    : FaIcon(FontAwesomeIcons.heart,
                                        color: primaryWhiteColor, size: 20),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _renderNumberStar(rateStar) {
    int numberStartStroke = (5 - rateStar).toInt();

    List<Widget> listStar = [];
    for (int i = 1; i <= rateStar; i++) {
      listStar.add(const FaIcon(FontAwesomeIcons.solidStar,
          size: 16, color: Color(0xffE5AA63)));
    }
    if (0 < (rateStar % listStar.length) && (rateStar % listStar.length) < 1) {
      listStar.add(const FaIcon(FontAwesomeIcons.solidStarHalfStroke,
          size: 16, color: Color(0xffE5AA63)));
    }
    for (int i = 0; i < numberStartStroke; i++) {
      listStar.add(const FaIcon(FontAwesomeIcons.star,
          size: 16, color: Color(0xffE5AA63)));
    }

    listStar.add(Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        rateStar.toString(),
        style: TextStyle(
          color: primaryDarkColor,
          fontSize: 14,
        ),
      ),
    ));
    return Row(
      children: listStar,
    );
  }

  void _gotoProductDetailScreen(LuxuryProduct product, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailProductScreen(
                  luxuryProduct: product,
                )));
  }
}
