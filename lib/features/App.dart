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
import 'profile/profile.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App Flutter',
      theme: ThemeData(),
      scrollBehavior: MyCustomScrollBehavior(),
      // supportedLocales: const [
      //   Locale('en', ''),
      //   Locale('vi', ''),
      // ],
      home: const AppContent(),
    );
  }
}

class AppContent extends StatefulWidget {
  const AppContent({Key? key}) : super(key: key);

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  int selectedIndex = 0;

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
      return renderNotifications();
    } else if (selectedIndex == 3) {
      return renderProfiles();
    }
  }

  HomeScreen? homeScreen;
  Profile? profileScreen;
  renderHomeContent() {
    homeScreen = const HomeScreen();
    return homeScreen;
  }

  renderNotifications() {}

  renderSearch() {}

  renderProfiles() {
    profileScreen = const Profile();
    return profileScreen;
  }

  renderFloatingBtnSearch() {
    return FloatingActionButton(
      hoverColor: primaryColor,
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
          items: listLuxuryPerfumeProduct,
          searchLabel: 'Tìm kiếm',

          // searchStyle: TextStyle(),
          suggestion: Center(
            // child: Text('Test'),
            child: ListView.builder(
                itemCount: listLuxuryPerfumeProduct.length,
                itemBuilder: (BuildContext context, int index) {
                  final LuxuryProduct = listLuxuryPerfumeProduct[index];
                  return ListTile(
                    selectedColor: primaryColor,
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(LuxuryProduct.image),
                              fit: BoxFit.cover)),
                    ),
                    title: Text(LuxuryProduct.name),
                    subtitle: Text(
                      LuxuryProduct.description,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(LuxuryProduct.currentPrice.toString()),
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
          builder: (LuxuryProduct) => Container(
            child: ListTile(
              selectedColor: primaryColor,
              leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(LuxuryProduct.image),
                          fit: BoxFit.cover))),
              title: Text(LuxuryProduct.name),
              subtitle: Text(
                LuxuryProduct.description,
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(LuxuryProduct.currentPrice.toString()),
              isThreeLine: true,
            ),
          ),
        ));
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
            final LuxuryProduct = listLuxuryPerfumeProduct[index];
            return ListTile(
              selectedColor: primaryColor,
              leading: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(LuxuryProduct.image),
                        fit: BoxFit.cover)),
              ),
              title: Text(LuxuryProduct.name),
              subtitle: Text(
                LuxuryProduct.description,
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(LuxuryProduct.currentPrice.toString()),
              isThreeLine: true,
            );
          }),
    );
  }
}
