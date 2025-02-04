import 'package:flutter/material.dart';
import './product.dart';

//Mix In: It's like a class with a bunch or things or UTILITIES that you may need and use without exteding
//The different besides that you can use mixin with a lot of classes, you can exten only one..
//..is that you extends for example a Person extends from Mammal, that's logic
//But a person wont extend from a bunch or things that can be used from a lot of objects like animals..
//..or  stores etc.. So if you have things that can be used for a lot of things, use create a mixin
//..Cause that mixin will be then use for a lot of things, Like the ChangeNotifiwe : )

//ChangeNotifier is like inherited widget and this is allow us to make communication tunnels...
//..with the help of the context we're getting in every widget
class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  var showFavoritiesOnly = false;

  List<Product> get items {
    //returning a copy of the list with the spread operator
    //I do this cause i dont wanna return a pointer at my object on memory
    //Thats because if a return a pointer, whenever something happend to that object, and then i call..
    //notifyLister(), the data will rebuild incorrectly
    //It is better that when you data changes you call notifiListener() from this class, which is..
    //THE PROVIDER
    if (showFavoritiesOnly) {
      return [..._items.where((prodItem) => prodItem.isFavorite).toList()];
    }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  //NOT GLOBALLY BUT LOCAL
  void showFavoritesOnly() {
    showFavoritiesOnly = true;
    notifyListeners();
  }

  //NOT GLOBALLY BUT LOCAL
  void showAll() {
    showFavoritiesOnly = false;
    notifyListeners();
  }

  //It is better that when you data changes you call notifiListener() from this class the provider
  void addProduct() {
    // _items.add('');
    //This method is to notify all the listener of this provider
    notifyListeners();
  }
}
