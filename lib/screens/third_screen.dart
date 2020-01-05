import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:complex_ui/models/car.dart';

Car currentCar = carList.cars[0];

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
            margin: EdgeInsets.only(left: 25),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            )),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 25),
            child: Icon(Icons.favorite_border),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: LayoutStarts(),
    );
  }
}

class LayoutStarts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[CarDetailsAnimation(), CustomBottomSheet()],
    );
  }
}

class CarDetailsAnimation extends StatefulWidget {
  @override
  _CarDetailsAnimationState createState() => _CarDetailsAnimationState();
}

class _CarDetailsAnimationState extends State<CarDetailsAnimation> {
  @override
  Widget build(BuildContext context) {
    return CarDetails();
  }
}

class CarDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 30),
            child: _carTitle(),
          ),
          Container(
            width: double.infinity,
            child: CarCarousel(),
          ),
        ],
      ),
    );
  }

  Widget _carTitle() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 38),
                children: [
                  TextSpan(text: currentCar.companyName),
                  TextSpan(text: "\n"),
                  TextSpan(
                      text: currentCar.carName,
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ]),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(style: TextStyle(fontSize: 16), children: [
            TextSpan(
                text: currentCar.price.toString(),
                style: TextStyle(color: Colors.grey[20])),
            TextSpan(
              text: " / day ",
              style: TextStyle(color: Colors.grey),
            )
          ]))
        ]);
  }
}

class CarCarousel extends StatefulWidget {
  @override
  _CarCarouselState createState() => _CarCarouselState();
}

class _CarCarouselState extends State<CarCarousel> {
  static final List<String> imgList = currentCar.imgList;

  final List<Widget> child = _map<Widget>(imgList, (index, String assetsName) {
    return Container(
      child: Image.asset(
        "assets/$assetsName",
        fit: BoxFit.fitWidth,
      ),
    );
  }).toList();

  static List<T> _map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            height: 250,
            viewportFraction: 1.0,
            items: child,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _map(imgList, (index, assetName) {
                return Container(
                  width: 50,
                  height: 2,
                  decoration: BoxDecoration(
                    color:
                        _current == index ? Colors.grey[100] : Colors.grey[600],
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

class CustomBottomSheet extends StatefulWidget {
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  double maxSheetTop = 400;
  double minSheetTop = 30;
  double sheetTop = 400;

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: sheetTop,
      left: 0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded ? sheetTop = 400 : sheetTop = minSheetTop;
            isExpanded = !isExpanded;
          });
        },
        child: SheetContainer(),
      ),
    );
  }
}

class SheetContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sheetItemHeight = 110;
    return Container(
      padding: EdgeInsets.only(top: 25),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        color: Color(0xfff1f1f1),
      ),
      child: Column(
        children: <Widget>[
          drawerHandle(),
        ],
      ),
    );
  }

  Widget drawerHandle() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 3,
      width: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffd9dbdb),
      ),
    );
  }
}

