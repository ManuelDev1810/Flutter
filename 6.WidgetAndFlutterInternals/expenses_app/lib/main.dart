import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

//Flutter wanna give you a 60fps app, so it updates the screen 60 times per second...
//So it redraw the pixels 60 persecond

//For the first time when it draw it for the first time it need to figure out the position...
//.. of every element , the color, the height etc. So it need configure every single pixel on the screen
//For the refreshes of the user interface, if nothing change, flutter takes the old information..
//it already has and paints it on the creen, that is super fast and every efficient

//So refreshes is not a problem, but it is when have to calculate everything and so

//------------------------------------------------------------------------------------

//Flutter does not only have one tree it has a second and even a third three
//The widger tree The Element tree and the Render tree
//You control The Widget tree with your code the other ones are controlled internally by flutter...
//..Based on your widget three

//Element tree just hold the references to the widget(that is the configuration)...
//For exampel if you have a container with the a color..
//The element is the container that hold a reference to the color (THE COLOR IS THE WIDGET)
//The same element that has a reference the configuration(WIDGET TREE), has one reference..
//To the render tree to show it up on the screen

//When the build method run it only rebuild the Widget tree, i mean only the configuration
//The element tree does not rebuld with every call to the build method
//The element tree take that configuration (widget tree) and put in on the render tree
//The element tree is an object in memory
//For every widget, flutter create an element

//So you know that a statufull element has setState that call rebuild, flutter create a state objet as well..
//this state object is an indepent object, its an indeoent object on memory, is also conected to the element..
//Coonected to the element not the widget

//These elements are also pointed to the render box, that is what you see on the screen(RENDER TREE)
//Whenever flutter detect an element that is not redner to the screen it does render it to the screen
//And it does so by looking at the widget at witch this element point which hold all the information you..
//..need for painting it to the screen, like a background color, a border etc

//So the element tree is the middleman that connect the configuration to the render
//So whhen it is build call? It is called on two ocations
//1- SetState, for example when you delete an element
//2- When you se mediaquery of or theme of, so when you the soft keyboard showed up..
//It also rebuild or when you put your phone on landscape

//The widget tree itself is inmutable, that meaans you cant change the property of an existing widget
//So you cant say this container now will have a color of white by adding a property
//Instead you can override the container with a brand new container that has a new configuration

//------------------------------------------------------------------------------------

//How does this work if the widges are replaced with new instances, does this menas that..
//.. the eleement and render are also rebuild? NO see

//When you called setState the widget is marked as dirty which means its replaced with a new one
//That new one hold the new configuration, and it will replace the old one, but the state object,
//... the state object does not change, so the state object is detached from the widget object

//Then the build method is  called so we rebuild all widget tree, for example for a container...
//.. for a container well have a new instance and for the text well have a new instance
//And what does this mean for the element and the render tree, since we have two new widget instances..
//So two new brand objcts stored in memory, it means that the elemnts in the render are also replaced?
//NO, the cool thing about is that element hold a reference at a widget and they also hold some information..
//on how to identify their related widget

//The element tree knows that it was connected to a container or a text widget etc
//Since this is know what it does its that the elementn now update the reference to the new Widget..
//And the old reference is cleared
//Then it passes this information on to the render object with is kept, so that the render object...
//can update in the places  where it needsto update, so for example if the render object is the same..
//But the text changed, it'll only render the text

//So the element tree will update the reference when it changes, if it changes will tell the render tree..
//..that it changes and will render.
//So the element is not rebuld, but the reference is.

//So you are changing the reference of something on the redner tree, maybe the container...
//But not the reference of the color because it does not change. AMAZING

//This is why the entire sreen does not render

//------------------------------------------------------------------------------------

//When the something of the media query changes like the soft keyboard, mediaquery trigger..
//.. mediaquery triggers rebulds of all the widgets that refer to it  (LOOK AT THE CONSTURCTOR IN THE CONSOLE)



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build() MyHomePageState');
    return MaterialApp(
      title: 'Personal Expens',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          errorColor: Colors.red,
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}


//MixIn: Add features from a class into your class, is like inherint properties or methods..
//..from a class without fullly inherint everything
//This only can be used in a statefull widget
class _MyHomePage extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shows',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  @override
  void initState(){
    //This line is saying that whenever my lifecycle state changes i want  you..
    //..to go to a certain observer and call the didChangeAppLifecycleState method
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  //This method comes from the mix in, and now becuase of the trigger in initState..
  //..this method is gonna be triggered whenever  the app lifecycle changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose(){
    //This is for removing didChangeAppLifecycleState method
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  //Video 149
  //We have a problem deleting widgets when the background of the avatar is random
  //This is because thw widget is deleted but the state is not deleted, the state..
  //.. is only deleted after flutter determined that this element here is not needed anymroe
  //How flutter check it this is needed or not, well when fluutter rebuild the widget tree..
  //It also checks the element tree and sees if it needs to change something which in the end leads..
  //..to a change on the screen. It goes from top to bottom and the first check the listview..
  //Is this ListView a widget in same level? Yes we have it
  //Then the element tree go to second element which is a item, ang see that widget of that element..
  //..was removed, so that means that the third item is going up, (so the third widget is the second now)
  //And then question, is this item a widget in same level? It is yes, so put that state on that widget..
  //..THE STATE OF THE SECOND ON THE THIRD WIDGET THAT NOW IS THE SECOND.. FOR THAT REASON THE COLOR IS THE SAME
  // so when it goes to the third item..
  //..it realeses that there is not widget there because it went up, so it delete the element and the state

  //So we need some way tell flutter that theses items are not identified only by type but also by something else..
  //This tool is a key, so flutter wont compare only the type and but also the key on similar types like the items
  //So when it sees that the element 2 is destroyed insteanf of putting the third in the 2, it knows that the 2,
  //was deleted because the 3 does not have the key of the 2, and destroyed the state of the 2 too

  //Just use it when needed, cause flutter does not need it, only use in situations like this when the item is
  //an statefull class cause the color change dynamiacly
  //keys only matter if you're working with stateful widgets in a list




  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((item) => item.id == id);
    });
  }

  List<Widget> _buildLandSacapeContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txListWidget,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.title,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txListWidget,
  ) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txListWidget
    ];
  }

  Widget _buildCapertinoBar() {
    return CupertinoNavigationBar(
      middle: const Text(
        'Personal Expenses',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          ),
        ],
      ),
    );
  }

  Widget _buildApp() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
  }

  //In flutter every widget has its own context and thats the context you get in the build method
  //The context is the element of a widget in the elemnt tree you can say
  //It is information about the widget and its location in the widget tree   
  //This is how the element tree knows about all the widget and all the relationshipns bout them
  
  //There is something called the inheritWidget, we never used this class but theme and mediaquery use it 
  //behinf the scene, and it used to get a direc tunel to the a widget from another class with the help 
  //of context

  //And so we can use this like a tunel, look the image 147 

  @override
  Widget build(BuildContext context) {
    print('build() MyHomePage');
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = _buildApp();

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              ..._buildLandSacapeContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),
            if (!isLandScape)
              //Spread operator, you use in list or or method that return a list
              //This tell dart that you want pull all the elements out as single elements
              ..._buildPortraitContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  } 
}
