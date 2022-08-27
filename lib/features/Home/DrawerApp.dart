import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../common/theme.dart';

class DrawerApp extends StatefulWidget {
  const DrawerApp({Key? key}) : super(key: key);

  @override
  State<DrawerApp> createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        elevation: 2,
        width: MediaQuery.of(context).size.width * 0.78,
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 80),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/logoQ.jpg",
                      ),
                    ))),
            Divider(
              height: 1,
              color: primaryOrangeColor,
            ),
            ListTile(
              iconColor: primaryColor,
              textColor: primaryColor,
              selectedColor: primaryOrangeColor,
              leading: Icon(Icons.home),
              title: Text('Home'),
              selected: _selectedDestination == 0,
              onTap: () => selectDestination(0),
            ),
            ListTile(
              iconColor: primaryColor,
              textColor: primaryColor,
              selectedColor: primaryOrangeColor,
              leading: Icon(Icons.list_alt),
              title: Text('About something'),
              selected: _selectedDestination == 1,
              onTap: () => selectDestination(1),
            ),
            ListTile(
              iconColor: primaryColor,
              textColor: primaryColor,
              selectedColor: primaryOrangeColor,
              leading: Icon(Icons.shopping_cart),
              title: Text('About something'),
              selected: _selectedDestination == 2,
              onTap: () => selectDestination(2),
            ),
            ListTile(
              iconColor: primaryColor,
              textColor: primaryColor,
              selectedColor: primaryOrangeColor,
              leading: Icon(Icons.favorite),
              title: Text('About something'),
              selected: _selectedDestination == 3,
              onTap: () => selectDestination(3),
            ),
            ListTile(
              iconColor: primaryColor,
              textColor: primaryColor,
              selectedColor: primaryOrangeColor,
              leading: Icon(Icons.app_registration_rounded),
              title: Text('About something'),
              selected: _selectedDestination == 4,
              onTap: () => selectDestination(4),
            ),
            ListTile(
              iconColor: primaryColor,
              textColor: primaryColor,
              selectedColor: primaryOrangeColor,
              leading: Icon(Icons.history),
              title: Text('About something'),
              selected: _selectedDestination == 5,
              onTap: () => selectDestination(5),
            ),
            ListTile(
              iconColor: primaryColor,
              textColor: primaryColor,
              selectedColor: primaryOrangeColor,
              leading: Icon(Icons.info_outline),
              title: Text('About something'),
              selected: _selectedDestination == 6,
              onTap: () => selectDestination(6),
            ),
          ],
        ));
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
