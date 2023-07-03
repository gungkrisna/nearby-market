import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final String image;

  const CategoryCard({
    this.category,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Image.asset(
                image,
                width: 150,
                height: 150,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
            child: Text(
              category,
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
          ),
        ],
      ),
    );
  }
}
