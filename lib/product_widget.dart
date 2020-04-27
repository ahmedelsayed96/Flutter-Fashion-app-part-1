import 'package:flutter/material.dart';

import 'main.dart';

class ProductWidget extends StatelessWidget {
  Product product;

  ProductWidget(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          buildImage(),
          SizedBox(
            height: 5,
          ),
          Text(
            product.name.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${product.price} \$',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5,),

        ],
      ),
    );
  }

  Hero buildImage() {
    return Hero(
      tag: product.image,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: Image.asset(
          product.image,
          width: 140,
          fit: BoxFit.cover,
          height: 160,
        ),
      ),
    );
  }
}
