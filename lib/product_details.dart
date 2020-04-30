import 'dart:ui';

import 'package:fahsion/animator.dart';
import 'package:fahsion/main.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  Product product;

  ProductDetails(this.product);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> with SingleTickerProviderStateMixin {
  Product product;
  AnimationController controller;
  Animation ainmation;

  @override
  void initState() {
    this.product = widget.product;
    controller =AnimationController(vsync: this,duration: Duration(milliseconds: 800));
    ainmation =CurvedAnimation(parent: controller,curve: Curves.easeInOutBack);
    controller.forward();
    super.initState();
  }
@override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildListView(),
          buildCartAndFave(),
        ],
      ),
    );
  }

  Widget buildListView() {
    return ListView(
      children: <Widget>[
        buildTopSide(),
        AnimatedBuilder(
          animation: controller,
          builder: (context, snapshot) {
            return Transform.translate(
              offset: Offset(-100*(1-controller.value),0),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 30.0),
                child: Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
              ),
            );
          }
        ),
        AnimatedBuilder(
          animation: controller,
          builder: (context, snapshot) {
            return Transform.translate(
              offset: Offset(-200*(1-controller.value),0),
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  product.type,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            );
          }
        ),
        AnimatedBuilder(
          animation: controller,
          builder: (context, snapshot) {
            return Transform.translate(
              offset: Offset(0,20*(1-controller.value)),
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 16),
                child: Text(
                  'BOY NOW',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16, color: mOrage),
                ),
              ),
            );
          }
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 30),
              width: 30,
              height: 2,
              color: Colors.grey,
            ),
            Spacer(),
            Text('4.8'),
            Icon(Icons.star),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        AnimatedBuilder(
          animation: controller,
          builder: (context, snapshot) {
            return Transform.translate(
              offset: Offset(0,40*(1-controller.value)),
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 120, top: 30),
                child: Text(
                  product.description,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          }
        )
      ],
    );
  }

  Widget buildTopSide() {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        buildImage(size),
        buildTextBox('COLOR',
            right: size.width / 2 + 40 + 20,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            )),
        buildTextBox('PRICE',
            right: size.width / 2 - 40,
            child: Text(
              '${product.price}\$',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            )),
        buildTextBox('SIZE',
            right: size.width / 2 - 40 - 80 - 20,
            child: Text(
              'M',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            )),
      ],
    );
  }

  Widget buildTextBox(String text, {Widget child, double right}) {
    return AnimatedBuilder(
      animation: ainmation,
      builder: (context, snapshot) {
        return Positioned(
          height: 70,
          width: 80,
          bottom: 60 * ainmation.value,
          right: right,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.white.withOpacity(.3),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'COLOR',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    child
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Hero buildImage(Size size) {
    return Hero(
      tag: product.image,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
        child: Image.asset(
          product.image,
          width: size.width,
          height: 450,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildCartAndFave() {

    return Positioned(
      bottom: 0,
      right: 0,
      child: Row(
        children: <Widget>[
          Animator(
            builder: (context, snapshot,value) {
              return Transform.translate(
                offset: Offset(0,30*(1-value)),
                child: Container(
                  width: 60,
                  padding: EdgeInsets.all(14),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      color: mOrage,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
                ),
              );
            }
          ),
          Container(
            width: 60,
            padding: EdgeInsets.all(14),
            child: Icon(
              Icons.shop,
              color: Colors.white,
            ),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
