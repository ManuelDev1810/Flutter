import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  //Const constructor, only work when the properties of this class are final
  //This menas that when you create an instance of this class, this instance will be unchangeable
  //So every instance of this object its gonna be unmutable, you cant change it
  //And this is good because all the properties of this class are final so you cant really do something
  //..like instance.label = hola;
  //All tje statlesswidget are inmutable

  //Remember that all the widget are inmutable, when the build run flutter create new objects
  //It does not go around changing properties of classes, no, it create a new object and replace it
  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    print('build() ChartBar');
    //Cosntrains tell us how much space a certain widget may take
    return LayoutBuilder(
      builder: (context, constrains) {
        return Column(
          children: <Widget>[
            Container(
              height: constrains.maxHeight * 0.15,
              //The FittedBox forces its child into the avaialble space, so it shirks
              child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            Container(
              height: constrains.maxHeight * 0.6,
              width: 10,
              //Stack widget allow you  to put element on top of each other
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  //Now on top of this widger is this widget
                  //This allow us to create a box that is sized as a fraction of another value
                  //The heightFactor is between 0 and 1, 1 will be 60px because of our parent of parent container
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        //I put this border here so the container that are place on top of each other are...
                        //...matching up regarging their borders and their edges
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            Container(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
