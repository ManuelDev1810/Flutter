import 'package:flutter/material.dart';
import './favorities_screen.dart';
import './categories_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreen createState() => _TabsScreen();
}

class _TabsScreen extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          //The TabBar and the DefaultTabController connect to each other by flutter
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.category,
                ),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(
                  Icons.star,
                ),
                text: 'Favorities',
              ),
            ],
          ),
        ),
        //The TabBarView and the DefaultTabController connect to each other by flutter
        body: TabBarView(
          children: <Widget>[
            CategoriesScreen(),
            FavoritiesScreen(),
          ],
        ),
      ),
    );
  }
}
