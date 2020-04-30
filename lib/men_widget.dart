import 'package:fahsion/grid_animator.dart';
import 'package:fahsion/main.dart';
import 'package:fahsion/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class MenWidget extends StatefulWidget {
  @override
  _MenWidgetState createState() => _MenWidgetState();
}

class _MenWidgetState extends State<MenWidget> with SingleTickerProviderStateMixin {
  SolidController solidController = SolidController();
  bool showGrid = false;
  AnimationController controller;
  Animation animation;


  @override
  void initState() {
    controller =AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    animation =CurvedAnimation(parent: controller,curve: Curves.easeOutBack);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          buildTopBar(),
          SizedBox(
            height: 10,
          ),
          buildTabBar(),
          SizedBox(
            height: 10,
          ),
          buildGridView(),
          buildBottomSheet(),
          Container(
            height: 50,
            color: Colors.black,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('images/women/face.jpg'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Anna Shahohin'),
                  Spacer(),
                  Text(
                    'Fb.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Tw.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'In.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTopBar() {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        Spacer(),
        Text(
          'Men',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Spacer(),
        SizedBox(
          width: 40,
        )
      ],
    );
  }

  Widget buildTabBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'Laster',
              style: TextStyle(fontWeight: FontWeight.bold, color: mOrage),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  color: mOrage,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            )
          ],
        ),
        Text(
          'Papular',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Sole',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildGridView() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 80 / 100,
        children: getProductList()
            .map((p) => ProductWidget(
                  p,
                  showBuyNow: true,
                ))
            .toList(),
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
        'images/men/item1.jpg'));
    list.add(Product('Cuffed Beanie', 'Hat', '', 10, 'images/men/item2.jpg'));
    list.add(Product('Grey Beanie', 'Hat', '', 15, 'images/men/item3.jpg'));
    list.add(Product('Grey Beanie', 'Hat', '', 15, 'images/men/item4.jpg'));

    return list;
  }

  Widget buildBottomSheet() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: SolidBottomSheet(
              showOnAppear: showGrid,
              onHide: (){
                setState(() {
                  showGrid=false;
                });
                controller.reverse();
              },
              onShow: (){
                setState(() {
                  showGrid=true;
                });
                controller.forward();
              },
              toggleVisibilityOnTap: true,
              autoSwiped: true,
              controller: solidController,
              headerBar: buildBottomHeader(),
              body: buildBottomBody(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBottomHeader() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )),
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              'Shirts',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
              right: 20,
              top: 60 / 2 - 10,
              child: Icon(
                Icons.play_arrow,
                color: mOrage,
                size: 15,
              ))
        ],
      ),
    );
  }

  Widget buildBottomBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          color: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: <Widget>[
              buildProductCard(),
              Container(
                height: constraints.maxHeight > 170
                    ? constraints.maxHeight - 170
                    : 200,
                child: GridView.count(
                  crossAxisCount: 3,
                  children: showGrid?getListShirts().map((i) => buidImage(i)).toList():[],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildProductCard() {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, snapshot) {
        return Transform.translate(
          offset: Offset(0,60*(1-animation.value)),
          child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: Image.asset(
                    'images/women/image7.png',
                    width: 140,
                    fit: BoxFit.cover,
                    height: 160,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Coton Shirt',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'A modern style \nit has a narrow',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '20\$',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'BUY NOW',
                        style: TextStyle(fontWeight: FontWeight.bold, color: mOrage),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  List<String> getListShirts() {
    return [
      'images/women/image7.png',
      'images/women/image8.png',
      'images/women/image9.png',
      'images/women/image10.png',
      'images/women/image11.png',
      'images/women/image4.png'
    ];
  }

  Widget buidImage(String image) {
    return GridAnimatorWidget(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image.asset(
            image,
            width: 140,
            height: 160,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
