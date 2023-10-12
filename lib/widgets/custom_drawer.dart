import 'package:flutter/material.dart';

class CustomDrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Add your onTap logic for item 1
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Add your onTap logic for item 2
            },
          ),
        ],
      ),
    );
  }
}
