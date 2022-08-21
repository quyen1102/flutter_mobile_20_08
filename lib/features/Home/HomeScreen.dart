import 'package:flutter/material.dart';
import 'package:flutter_mobile_20_08/common/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              padding: const EdgeInsets.only(right: 10.0),
              icon: Icon(Icons.shopping_bag_outlined,
                  size: 26, color: primaryColor),
              onPressed: null,
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.menu, size: 26, color: primaryColor),
            onPressed: null,
          )),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            _renderListBtnFavorites(),
          ],
        ),
      ),
    );
  }

  _renderListBtnFavorites() {
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
    return Container(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(right: 18),
          itemCount: listFavorites.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                print(listFavorites[index]);
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
                    listFavorites[index],
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
