import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/theme.dart';
import '../../store/data/products.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int numberSelected = 0;

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
          (numberSelected != 0)
              ? InkWell(
                  onTap: _onTapRemoveSelected,
                  child: Container(
                    height: 30,
                    width: 100,
                    alignment: Alignment.center,
                    child: Text("(Remove $numberSelected)",
                        style: TextStyle(color: Colors.redAccent)),
                  ),
                )
              : Container()
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
                    const SizedBox(
                      height: 150,
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
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [primaryColor, primarySuperDarkColor],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
              )),
        ],
      ),
    );
  }

  Widget _renderListProduct() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listLuxuryPerfumeProduct.length,
        itemBuilder: (BuildContext context, int index) {
          final luxuryProduct = listLuxuryPerfumeProduct[index];
          return _renderItemListProduct(luxuryProduct);
        });
  }

  bool isChecked = false;
  Widget _renderItemListProduct(luxuryProduct) {
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

  void _onTapRemoveSelected() {}
}
