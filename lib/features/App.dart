import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_20_08/features/Home/HomeScreen.dart';
import 'package:flutter_mobile_20_08/features/login/login.dart';
import 'package:flutter_mobile_20_08/store/data/products.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:search_page/search_page.dart';

import '../common/horizontalScroll.dart';
import '../common/theme.dart';
import '../store/models/luxuryProduct.dart';
import 'Home/demoSceen/scrollToIndex.dart';
import 'products/cart.dart';
import 'products/detailProductScreen.dart';
import 'profile/profile.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'My App Flutter',
      theme: ThemeData(),
      scrollBehavior: MyCustomScrollBehavior(),
      // supportedLocales: const [
      //   Locale('en', ''),
      //   Locale('vi', ''),
      // ],
      // home: const AppContent(),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
          body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const AppContent();
          } else {
            return const Login();
          }
        },
      ));
}

class AppContent extends StatefulWidget {
  const AppContent({Key? key}) : super(key: key);

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  int selectedIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: renderFloatingBtnSearch(),
      body: Container(
        decoration: BoxDecoration(
          color: primaryWhiteColor,
        ),
        child: Center(child: renderContent(context)),
      ),
      bottomNavigationBar: renderBottomNavigationBar(context),
    );
  }

  renderContent(context) {
    if (selectedIndex == 0) {
      return renderHomeContent();
    } else if (selectedIndex == 1) {
      return renderSearch();
    } else if (selectedIndex == 2) {
      return renderCart();
    } else if (selectedIndex == 3) {
      return renderProfiles();
    }
  }

  HomeScreen? homeScreen;
  Profile? profileScreen;
  CartScreen? cartScreen;
  renderHomeContent() {
    homeScreen = const HomeScreen();
    return homeScreen;
  }

  renderCart() {
    cartScreen = const CartScreen();
    return cartScreen;
  }

  renderSearch() {}

  renderProfiles() {
    profileScreen = const Profile();
    return profileScreen;
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

  renderBottomNavigationBar(BuildContext context) {
    var colorOrigin = primaryColor;
    var colorActive = primaryDarkColor;

    return Container(
      height: 50 + MediaQuery.of(context).viewPadding.bottom,
      width: MediaQuery.of(context).size.width,
      color: primaryWhiteColor,
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _renderBarButton(
            0,
            'Home',
            // Icon(Icons.home_filled , color: colorOrigin, size: 24),
            // Icon(Icons.home_outlined , color: colorOrigin, size: 24),
            FaIcon(FontAwesomeIcons.house, color: colorOrigin, size: 22),
            FaIcon(FontAwesomeIcons.house, color: colorActive, size: 24),
          ),
          _renderBarButton(
            1,
            'Search',
            FaIcon(FontAwesomeIcons.magnifyingGlass,
                color: colorOrigin, size: 24),
            FaIcon(FontAwesomeIcons.magnifyingGlass,
                color: colorActive, size: 26),
          ),
          _renderBarButton(
            2,
            'cart',
            // Icon(Icons.shopping_bag_outlined,color: colorOrigin, size: 24 ),
            // Icon(Icons.shopping_bag_outlined,color: colorActive, size: 26 ),
            FaIcon(FontAwesomeIcons.bagShopping, color: colorOrigin, size: 24),
            FaIcon(FontAwesomeIcons.bagShopping, color: colorActive, size: 26),
          ),
          _renderBarButton(
            3,
            'Profile',
            // Icon(Icons.person_outline,color: colorOrigin, size: 26),
            // Icon(Icons.person_outline,color: colorActive, size: 28 ),
            FaIcon(FontAwesomeIcons.user, color: colorOrigin, size: 24),
            FaIcon(FontAwesomeIcons.solidUser, color: colorActive, size: 26),
          ),
        ],
      ),
    );
  }

  _renderBarButton(index, label, icon, activeIcon) {
    var text = index == selectedIndex
        ? Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          )
        : const Text('');

    final Widget currentIcon = index == selectedIndex ? activeIcon : icon;

    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () => _onItemTapped(index, context),
        child: Container(
          // alignment: Alignment.center,
          height: 50,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          // child: currentIcon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              currentIcon,
              // const SizedBox(height: 5,),
              // text
            ],
          ),
        ),
      ),
    );
  }

  // static const qrCodeScreenIndex = 2;

  void _onItemTapped(int index, BuildContext context) {
    // if (qrCodeScreenIndex == index) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (homeScreen) => const QRScreenDemo()),
    //   );
    //   return;
    // }

    setState(() {
      selectedIndex = index;
    });
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

  void _gotoProductDetailScreen(LuxuryProduct product, context) {
    print("tapp");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailProductScreen(
                  luxuryProduct: product,
                )));
  }
}

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: listLuxuryPerfumeProduct.length,
          itemBuilder: (BuildContext context, int index) {
            final luxuryProduct = listLuxuryPerfumeProduct[index];
            return ListTile(
              onTap: () {
                _gotoProductDetailScreen(luxuryProduct, context);
              },
              selectedColor: primaryColor,
              leading: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(luxuryProduct.image),
                        fit: BoxFit.cover)),
              ),
              title: Text(luxuryProduct.name),
              subtitle: Text(
                luxuryProduct.description,
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(luxuryProduct.currentPrice.toString()),
              isThreeLine: true,
            );
          }),
    );
  }

  void _gotoProductDetailScreen(LuxuryProduct product, context) {
    print("tapp");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailProductScreen(
                  luxuryProduct: product,
                )));
  }
}
