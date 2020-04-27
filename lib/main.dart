import 'package:flutter/material.dart';

import 'animator.dart';
import 'bottomMenu.dart';
import 'product_widget.dart';

void main() => runApp(MyApp());
const mOrage = const Color(0xffEA6940);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        buildImage(size),
        buildRotatedText(),
        buitSpringTextAndCollection(),
        Animator(
          delay: Duration(milliseconds: 100),
            builder: (context, snapshot, value) {
          return Transform.translate(
            offset: Offset(0,500*(1-value)),
              child: buildBottomList(size));
        }),
        buildBlackList(size),
        buildBottomMenu(size)
      ],
    ));
  }

  Positioned buildRotatedText() {
    return Positioned(
      left: 20,
      top: -20,
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
          'pre feeling',
          style: TextStyle(
              fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Image buildImage(Size size) {
    return Image.asset(
      'images/women/cover_image.png',
      fit: BoxFit.cover,
      width: size.width,
    );
  }

  Widget buitSpringTextAndCollection() {
    return Positioned(
      left: 20,
      top: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Animator(
              delay: Duration(milliseconds: 300),
              builder: (context, snapshot, value) {
                return Transform.translate(
                  offset: Offset(-50 * (1 - value), 0),
                  child: Text(
                    'just for you',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                );
              }),
          SizedBox(
            height: 30,
          ),
          Animator(
              curve: Curves.easeOutSine,
              delay: Duration(milliseconds: 500),
              builder: (context, snapshot, value) {
                return Transform.translate(
                  offset: Offset(-400 * (1 - value), 0),
                  child: Text(
                    'SPRING',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 70),
                  ),
                );
              }),
          Animator(
              curve: Curves.easeOutSine,
              delay: Duration(milliseconds: 600),
              builder: (context, snapshot, value) {
                return Transform.translate(
                  offset: Offset(-400 * (1 - value), 0),
                  child: Text(
                    'Collection',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget buildBottomList(Size size) {
    return Container(
      width: size.width,
      height: size.height / 2,
      margin: EdgeInsets.only(top: size.height / 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 30),
            child: Text(
              'you also may like ',
              style: TextStyle(fontSize: 17),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    getProductList().map((p) => ProductWidget(p)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Product> getProductList() {
    List<Product> list = [];

    list.add(Product(
        'Woleen Tee',
        'Grandad Shirt',
        'A casual style this, \nGrandad shirt is  made from pure coton \N'
            'Wide neckline with narrow, covered elastication and gathers for added width, 3/4-length, raglan puff sleeves with narrow elastication at the cuffs, and a straight-cut hem',
        36,
        'images/women/image6.png'));
    list.add(
        Product('Cuffed Beanie', 'Hat', '', 10, 'images/women/image11.png'));
    list.add(Product('Grey Beanie', 'Hat', '', 15, 'images/women/image10.png'));

    return list;
  }

  Widget buildBlackList(Size size) {
    return Positioned(
      right: 0,
      top: size.height / 2 - 40,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
        height: 80,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 30,
            ),
            Text(
              'Fb.',
              style: TextStyle(color: mOrage, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              'Tw.',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              'In.',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomMenu(Size size) {
    return Positioned(
      bottom: 5,
      width: size.width - 16,
      child: BottomMenu(),
    );
  }
}

class Product {
  String name;
  String type;
  String description;
  double price;
  String image;

  Product(this.name, this.type, this.description, this.price, this.image);
}
