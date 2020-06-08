import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shimmer/shimmer.dart';

class ProductWaitTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      child: Card(
        child: Row(
          children: <Widget>[
            Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  color: Colors.grey[300],
                  height: 135,
                  width: 127,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: Container(
                          color: Colors.grey[300],
                          height: 20,
                          width: 220,
                        )),
                    Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: Container(
                          color: Colors.grey[300],
                          height: 20,
                          width: 220,
                        )),
                    Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: Container(
                          color: Colors.grey[300],
                          height: 20,
                          width: 220,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
