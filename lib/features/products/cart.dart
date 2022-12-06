import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../store/data/products.dart';
import '../../store/models/luxuryProduct.dart';
import '../../store/provider/CartProvider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<LuxuryProduct> listProducts = listLuxuryPerfumeProduct;
  int numberSelected = 0;
  int _initNumberProduct = 0;
  double _totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "My Cart",
          style: TextStyle(color: primaryDarkColor),
        ),
        centerTitle: true,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: primaryDarkColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
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
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _renderListProduct(),
                    _renderInputPromoCode(),
                    const SizedBox(
                      height: 300,
                    )
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 0,
          //   right: 0,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Colors.blue,
          //     ),
          //     height: 60,
          //     width: MediaQuery.of(context).size.width,
          //     child: Row(
          //       children: [
          //         Container(
          //           height: 60,
          //           width: 30,
          //           decoration: BoxDecoration(
          //             color: Colors.red,
          //           ),
          //         ),
          //         Container(
          //           height: 60,
          //           width: 30,
          //           decoration: BoxDecoration(
          //             color: Colors.red,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [primaryColor, primarySuperDarkColor],
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return primaryColor;
    }
    return Colors.red;
  }

  deleteItem() {}

  shareItem() {}

  Widget _renderListProduct() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listProducts.length,
        itemBuilder: (BuildContext context, int index) {
          final luxuryProduct = listLuxuryPerfumeProduct[index];
          return _renderItemListProduct(luxuryProduct);
        });
  }

  bool isChecked = false;
  Widget _renderItemListProduct(luxuryProduct) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 3,
            onPressed: deleteItem(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: FontAwesomeIcons.trashCan,
            label: 'Delete',
          ),
          SlidableAction(
            flex: 2,
            onPressed: shareItem(),
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            icon: FontAwesomeIcons.share,
            label: 'Share',
          ),
        ],
      ),
      child: _renderCardItem(luxuryProduct),
    );
  }

  _renderCardItem(luxuryProduct) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(children: [
        Container(
            child: Checkbox(
          checkColor: Colors.white,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        )),
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: Color(0xffece2dc),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                height: 150,
                width: 80,
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          luxuryProduct.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: primaryDarkColor,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Container(
                        height: 40,
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
                            _renderCountProduct(luxuryProduct),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  _renderCountProduct(LuxuryProduct product) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _renderBtnHandleCount(_reduceProduct(product), "-"),
          _renderViewNumberCount(product.quantity),
          _renderBtnHandleCount(_addProduct(product), "+"),
        ],
      ),
    );
  }

  _renderViewNumberCount(numberCountProduct) {
    return Container(
      width: 30,
      height: 20,
      alignment: Alignment.center,
      child: Text(numberCountProduct.toString(),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          )),
    );
  }

  _renderBtnHandleCount(onTap, String handleType) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryLightColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: primaryColor, width: 1),
            ),
            child: Text(
              handleType,
              style: TextStyle(
                fontSize: 20,
                color: primaryDarkColor,
              ),
            )));
  }

  _addProduct(LuxuryProduct product) {
    print("0");
    // setState(() {
    //   if (_initNumberProduct < 10) {
    //     product.incrementQuantity();
    //     _totalPrice = _initNumberProduct * product.currentPrice;
    //   }
    // });
  }

  _reduceProduct(LuxuryProduct product) {
    print("0");
    // setState(() {
    //   if (_initNumberProduct > 0) {
    //     // product.decrementQuantity();
    //     // _totalPrice = _initNumberProduct * product.currentPrice;
    //   }
    // });
  }

  void _onTapRemoveSelected() {}

  _renderInputPromoCode() {
    return Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: primaryLightColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Container(
              height: 30,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.45,
              child: TextField(
                maxLines: 1,
                cursorColor: primaryOrangeColor,
                cursorHeight: 20,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryLightColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryLightColor),
                  ),
                  border: null,
                  hintText: 'Promo Code',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: submitPromoCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryDarkColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  elevation: 0,
                  onPrimary: Colors.white,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                child: Text("Apply")),
          ],
        ));
  }

  void submitPromoCode() {}
}
