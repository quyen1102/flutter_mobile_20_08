import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import '../../common/theme.dart';
import '../../store/data/products.dart';
import '../../store/models/luxuryProduct.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({Key? key, required this.product}) : super(key: key);
  final LuxuryProduct product;

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final List<LuxuryProduct> listProduct = listLuxuryPerfumeProduct;
  double _totalPrice = 0;
  int _currentSliderIndex = 0;
  int _initNumberProduct = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _renderSliverAppBarr(size, widget.product),
        SliverToBoxAdapter(child: _renderBody(size, widget.product)),
        SliverToBoxAdapter(child: renderCarouselSlider(context)),
        const SliverToBoxAdapter( child: SizedBox(height: 30))
      ],
    ),
      bottomNavigationBar: _renderBottomNavigationBar() ,
    );
  }

  _renderBottomNavigationBar(){

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            height: 50,
            child: Column(
              children:  [
                const Text("Total price", style: TextStyle(color: Colors.black54, fontSize: 15)),
                (_totalPrice > 0)
                    ? Text("\$${_totalPrice.toStringAsFixed(2)}",  style: TextStyle(color: primarySuperDarkColor, fontSize: 20, fontWeight: FontWeight.bold))
                    : Text("- -  - -",  style: TextStyle(color: primarySuperDarkColor, fontSize: 22))
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _onPressAddToCart,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 26),
              primary: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius:  BorderRadius.circular(30.0)
              ),
              elevation: 0,
              onPrimary: Colors.white,
              textStyle:const  TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            label: const Text('Add to Cart'),
            icon: const Icon(Icons.shopping_bag_outlined,  size: 24, color: Colors.white,),
          ),

        ],
      ),
    );
  }
  _onPressAddToCart(){

  }
  _renderSliverAppBarr(size, product) {
    return SliverAppBar(
      pinned: true,
      leadingWidth: double.infinity,
      actions: [
        IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      backgroundColor: primaryColor,
      expandedHeight: size.height * 0.5,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.38,
        title: const Text(
          "Product Details",
        ),
        centerTitle: true,
        background: _renderBackgroundImage(size, product.image),
      ),
    );
  }
  _renderBackgroundImage(size, image) {
    // var image;
    // if (imagePath != '' && imagePath != null) {
    //   image = NetworkImage("$baseUrl/api/files/$imagePath");
    // }
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/product_01.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              // height: 70,
              // width: 70,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:AssetImage('$image'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  _renderBody(Size size, LuxuryProduct product) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              product.name.toString().trim(),
              textAlign: TextAlign.left,
              style:  TextStyle(
                color: primaryDarkColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              "Brand : ${product.brandName.toString().trim()}",
              textAlign: TextAlign.left,
              style:  TextStyle(
                color: primaryDarkColor,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          _renderPriceAndRateStar(product),
          _renderCountProduct(widget.product),
          Divider(
            color: primaryDarkColor,
            height: 1,
            thickness: 0.5,
          ),
          const SizedBox(height: 16),
          _renderContent("Description", product.description),
          _renderContent("Instructions for use", product.useType),
          const SizedBox(height: 16),
          Divider(
            color: primaryDarkColor,
            height: 1,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }

  _renderContent(String title, String content){
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const  EdgeInsets.symmetric(vertical:10),
          child: Text(
          title,
          style:  TextStyle(
            fontSize: 18,
            color: primaryDarkColor,
            fontWeight: FontWeight.bold,
          )
        ),),
        ReadMoreText(
          content,
           trimLines: 3,
          textAlign: TextAlign.justify,
           style: const  TextStyle(
             fontSize: 16,
             height: 1.6,
           ),
           colorClickableText: primaryOrangeColor,
           trimMode: TrimMode.Line,
           trimCollapsedText: 'Read more',
           trimExpandedText: 'Show less',
           moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
         ),
      ],
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

  _renderPriceAndRateStar(LuxuryProduct product){
    return   Row(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            child:  _renderNumberStar(product.rateStar),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
            ]
          ),
        ),

      ],
    );

  }


  renderCarouselSlider(BuildContext context) {
    return Container(
      height: 550,
      decoration: const  BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _renderTitle("Other products"),
                _btnSeeMore(),
              ]
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 450,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval:const   Duration(seconds: 5),
              autoPlayAnimationDuration:const  Duration(milliseconds: 2000),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: (int i, CarouselPageChangedReason reason) {
                setState(() {
                  _currentSliderIndex = i;
                });
              },
              scrollDirection: Axis.horizontal,
            ),
            items: listProduct.map((product) {
              return Builder(
                builder: (BuildContext context) {
                  return _renderItemProduct(product);
                },
              );
            }).toList(),
          ),
        ]
      ),
    );
  }

  _renderTitle(text) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        '$text',
        style:  TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: primaryDarkColor,
        ),
      ),
    );
  }

  _renderItemProduct(LuxuryProduct product) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return InkWell(
      onTap: () {
        _gotoProductDetailScreen(product);
      },
      child: SizedBox(
        height: 400,
        width: width,
        // margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              height: 240,
              width: width,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _renderPrice(product),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                product.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _btnSeeMore() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical:10),
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: () {
        },
        child: Text(
          "Xem thêm",
          style: TextStyle(fontSize: 12, color: primaryColor),
        ),
      ),
    );
  }

  _renderPrice(product){
    return   Row(
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
        const SizedBox(width: 16),
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
    );

  }

  void _gotoProductDetailScreen(LuxuryProduct product) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailProductScreen(product: product,))
    );
  }


  _renderCountProduct(LuxuryProduct product) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical:10, horizontal:26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _renderBtnHandleCount(_reduceProduct, "-"),
          _renderViewNumberCount(),
          _renderBtnHandleCount(_addProduct, "+"),

        ],
      ),
    );
  }

  _renderViewNumberCount(){
    return Container(
      width: 50,
      height: 20,
      alignment: Alignment.center,
      child: Text(_initNumberProduct.toString(),
        style:const TextStyle(
          fontSize: 18,
          color: Colors.black,
        )
      ),
    );
  }

  _renderBtnHandleCount( onTap, String handleType ){
    return  InkWell(
        onTap: onTap,
        child: Container(
            height: 35,
            width: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryLightColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: primaryColor, width:1),
            ),
            child: Text(
              handleType,
              style: TextStyle(
                fontSize: 20,
                color: primaryDarkColor,
              ),
            )
        )
    );
  }

  _addProduct(){
    setState(() {
      if(_initNumberProduct < 10){
        _initNumberProduct++;
        _totalPrice = _initNumberProduct * widget.product.currentPrice;
      }
    });
  }

  _reduceProduct(){
    setState(() {
      if(_initNumberProduct > 0){
        _initNumberProduct--;
        _totalPrice = _initNumberProduct * widget.product.currentPrice;
      }});
  }

}