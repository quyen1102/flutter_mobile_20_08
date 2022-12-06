import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_20_08/common/theme.dart';
import 'package:flutter_mobile_20_08/features/products/cart.dart';
import 'package:flutter_mobile_20_08/store/models/luxuryProduct.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';

import '../../store/data/products.dart';
import '../../store/models/listLuxuryProduct.dart';
import '../../store/provider/CartProvider.dart';
import '../products/detailProductScreen.dart';
import 'DrawerApp.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // get data from firebase
  CollectionReference luxuryProductRef =
      FirebaseFirestore.instance.collection('luxuryProduct');
  List<LuxuryProduct> listLuxuryProduct = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  _loadData() {
    luxuryProductRef.get().then(
      (QuerySnapshot querySnapshot) {
        for (var element in querySnapshot.docs) {
          LuxuryProduct product = LuxuryProduct.fromJson(element.data());
          listLuxuryProduct.add(product);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  final List<String> listFavorites = <String>[
    'Kids',
    'Women',
    'Cream',
    'Hiphop',
    'Men',
    'T-Shirt',
    'Kids',
    'Women',
    'Cream',
    'Hiphop',
    'Men',
    'T-Shirt',
  ];

  @override
  Widget build(BuildContext context) {
    // print("list product: ${listLuxuryProduct}");
    return Scaffold(
      floatingActionButton: renderFloatingBtnSearch(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: primaryColor),
        actions: [
          Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              position: const BadgePosition(start: 30, bottom: 28),
              child: IconButton(
                icon: Icon(Icons.shopping_bag_outlined, color: primaryColor),
                onPressed: _gotoCartScreen,
              )),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      drawer: const DrawerApp(),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _renderListBtnFavorites(),
              _renderCarouselSlider(context),
              _renderHotProductList(),
              const SizedBox(height: 10),
              _renderRecentOrderList(),
              // _renderListItemRecentProduct(luxuryProduct),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  int _currentSliderIndex = 0;
  _renderCarouselSlider(BuildContext context) {
    return Container(
      height: 120,
      // padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 120,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            autoPlayAnimationDuration: const Duration(milliseconds: 500),
            autoPlayCurve: Curves.fastOutSlowIn,
            // enlargeCenterPage: true,
            onPageChanged: (int i, CarouselPageChangedReason reason) {
              setState(() {
                _currentSliderIndex = i;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
          items: listLuxuryProduct.map((product) {
            return Builder(
              builder: (BuildContext context) {
                return _renderItemProductBanner(product);
              },
            );
          }).toList(),
        ),
      ]),
    );
  }

  _renderItemProductBanner(LuxuryProduct product) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          _gotoProductDetailScreen(product, context);
        },
        child: SizedBox(
          height: 100,
          width: width,
          // margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                height: 100,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: AssetImage(product.image), fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  renderFloatingBtnSearch() {
    return FloatingActionButton(
      backgroundColor: primaryDarkColor,
      child: Container(child: Icon(Icons.search)),
      tooltip: 'Search products',
      onPressed: () {
        _searchAction();
      },
    );
  }

  _searchAction() {
    showSearch(
        context: context,
        delegate: SearchPage<LuxuryProduct>(
          onQueryUpdate: print,
          items: listLuxuryProduct,
          searchLabel: 'Search here',
          barTheme: ThemeData(
              hintColor: Colors.white54,
              appBarTheme: AppBarTheme(
                backgroundColor: primaryColor,
              )),
          searchStyle: TextStyle(
            color: Colors.white,
          ),
          suggestion: Center(
            // child: Text('Test'),
            child: ListView.builder(
                itemCount: listLuxuryProduct.length,
                itemBuilder: (BuildContext context, int index) {
                  final luxuryProduct = listLuxuryProduct[index];
                  return ListTile(
                    onTap: () {
                      _gotoProductDetailScreen(luxuryProduct, context);
                    },
                    selectedColor: primaryColor,
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: AssetImage(luxuryProduct.image),
                              fit: BoxFit.cover)),
                    ),
                    title: Text(luxuryProduct.name),
                    subtitle: Text(
                      luxuryProduct.description,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(luxuryProduct.currentPrice.toString()),
                    isThreeLine: true,
                  );
                }),
          ),
          failure: const Center(
            child: Text('No product found :('),
          ),
          filter: (luxuryProduct) => [
            luxuryProduct.name,
            luxuryProduct.description,
            luxuryProduct.scent.toString(),
          ],
          // sort: (a, b) => a.compareTo(b),
          builder: (luxuryProduct) => Container(
            child: ListTile(
              onTap: () {
                _gotoProductDetailScreen(luxuryProduct, context);
              },
              selectedColor: primaryColor,
              leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: AssetImage(luxuryProduct.image),
                          fit: BoxFit.cover))),
              title: Text(luxuryProduct.name),
              subtitle: Text(
                luxuryProduct.description,
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(luxuryProduct.currentPrice.toString()),
              isThreeLine: true,
            ),
          ),
        ));
  }

  _renderListBtnFavorites() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(right: 18),
          itemCount: listLuxuryProduct.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                // print(listFavorites[index]);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                margin: const EdgeInsets.only(left: 18, top: 12, bottom: 12),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: primaryLightColor,
                      width: 1,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    listLuxuryProduct[index].name,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  _renderHotProductList() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _renderTitle("Popular"),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 13,
                    color: primaryColor,
                  ),
                ),
              )
            ],
          ),
          _renderListItemHotProduct(listLuxuryProduct),
        ],
      ),
    );
  }

  _renderRecentOrderList() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _renderTitle("Recent Products"),
            ],
          ),
          _renderListItemRecentProduct(listLuxuryProduct),
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

  _renderListItemHotProduct(List<LuxuryProduct> luxuryProducts) {
    return SizedBox(
        height: 350,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: luxuryProducts.length,
          itemBuilder: (context, index) {
            return _renderProductItem(luxuryProducts[index]);
          },
        ));
  }

  _renderProductItem(LuxuryProduct product) {
    return InkWell(
      onTap: () {
        _gotoProductDetailScreen(product, context);
      },
      child: Container(
        height: 300,
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              height: 260,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: AssetImage(product.image), fit: BoxFit.cover),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            _renderPrice(product),
          ],
        ),
      ),
    );
  }

  _renderPrice(product) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "\$${product.currentPrice.toString()}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xffE5AA63),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "\$${product.lastPrice.toString()}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  _renderListItemRecentProduct(List<LuxuryProduct> luxuryProducts) {
    List<Widget> list = [];
    for (var i = 0; i < luxuryProducts.length; i++) {
      list.add(_renderRecentProductItem(luxuryProducts[i]));
    }
    return Column(children: list);
  }

  _renderRecentProductItem(LuxuryProduct luxuryProduct) {
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
                                  (luxuryProduct.isLiked)
                                      ? (luxuryProduct.isLiked = false)
                                      : (luxuryProduct.isLiked = true);
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

  void _gotoCartScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CartScreen()));
  }
}
