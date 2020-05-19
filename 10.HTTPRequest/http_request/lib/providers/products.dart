import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  //Async code, is code that runs and that should not stop other code from counting
  //So this content will be availale some time in the future but not inmideally
  //It will be bad if we await for this to complete cause maybe your internet is slow..
  //..your app will be frozen
  Future<void> addProduct(Product product) {
    //This is async, we send this request but all the things continue, this is why you see that flutter..
    //..pop out the page and after some miliseconds you see the new product on the screen
    //..the pop is in edit product...

    //IT EXECUTE ALL THE SYNCHRONOUS CODE EVEN THE CODE ON THE EDIT PRODUCT OR THE MAIN..
    //..AND THEN WILL CHECK IF THE FUTURE IS DONE, IT IS IT WILL EXECUTE THAT CODE
    //OF COURSE, THIS IS CAUSE WE DONT USE AWAIT
    final url = 'https://flutter-update-735c3.firebaseio.com/products.json';
    //Returning the then method which if a future
    return http.post(url, body: json.encode({
      'title': product.title,
      'description': product.description,
      'imageUrl': product.imageUrl,
      'price': product.price,
      'isFavorite': product.isFavorite,
    })).then((response) {
      final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: json.decode(response.body)['name'],
    );
    _items.add(newProduct);
    notifyListeners();
    })
    //Putting the catchError here is better cause we are catching error for the post and for the then
    //If the error is thown in the post method the then method will be skipped
    //If i put the catch before the then, the login on the then method will run after the catch
    .catchError((error) {
      print(error);
      throw error;
    });
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id){
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
