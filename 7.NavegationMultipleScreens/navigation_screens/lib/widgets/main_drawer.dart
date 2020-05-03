import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  //Instead of using this build method you can of course put it in a different widget
  //If you have a widget which you only use in conjuntion with this widget here...
  //You could definely store that extra widget in the same file.
  //Tipically you do this when you use state or theme or something that trigger the Build method..
  //Cause that way you only trigger the build method of that widget and not all
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up',
              style: TextStyle(
                //This is the weight we put in taml file, we dont to put the fontFamily cause by default..
                //..is Raleway
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'Meals',
            Icons.restaurant,
            () {
              Navigator.of(context).pushNamed('/');
            }
          ),
          buildListTile(
            'Settings',
            Icons.settings,
            () {
              Navigator.of(context).pushNamed(FiltersScreen.routeName);
            }
          ),
        ],
      ),
    );
  }
}
