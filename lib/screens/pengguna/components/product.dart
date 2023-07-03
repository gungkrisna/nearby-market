import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productname;
  final String image;
  final String namapenjual;
  final int price;

  const ProductCard(
      {this.productname, this.image, this.price, this.namapenjual});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.grey[100],
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
              child: Column(
                children: [
                  Flexible(
                    child: Text(
                      productname + namapenjual,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'HelveticaLight',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    price.toString(),
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'HelveticaLight',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
