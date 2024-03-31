import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:Icon(
          Icons.menu,
        ) ,
        title: Text(
            'sds',
        ),
        actions:
          [
            IconButton(
              icon :Icon(
                Icons.notification_important,
              ),
              onPressed: onno,
            ),
          ],
      ),
      body: Container(
        color: Colors.purpleAccent,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.red,
              child: Text(
                'first',
                style:TextStyle(
                  fontSize: 70,
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Text(
                  'second',
                  style:TextStyle(
                    fontSize: 70,
                  ),
              ),
            ),
            Container(
              color: Colors.yellow,
              child: Text(
                  'third',
                style:TextStyle(
                  fontSize: 70,
                ),
              ),
            ),
            Container(
              color: Colors.green,
              child: Text(
                  'fourth',
                style:TextStyle(
                  fontSize: 70,
                ),
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                    image: NetworkImage(
                      'https://www.ikea.com/eg/en/images/products/smycka-artificial-flower-rose-red__0903311_pe596728_s5.jpg?f=s',
                    ),

                ),
                Container(
                  color: Colors.black.withOpacity(0.7),
                  width: 600,
                  padding: EdgeInsetsDirectional.only(
                    top: 30,
                    bottom: 50,
                  ),
                  child: Text(
                    'Flower',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void onno (){
    print('dsa');
  }
}