import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/product_model.dart';
import 'package:lojavirtual/tiles/product_grid_tile.dart';
import 'package:lojavirtual/tiles/product_list_tile.dart';

class CategoryScree extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoryScree(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data["title"]),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection("products").document(snapshot.documentID)
            .collection("items").getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    GridView.builder(
                      padding: const EdgeInsets.all(4),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 0.65
                      ),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){
                        Product data = Product.fromDocument(snapshot.data.documents[index]);
                        data.category = this.snapshot.documentID;
                        return ProductGridTile(data);
                      },
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.all(4),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){
                        Product data = Product.fromDocument(snapshot.data.documents[index]);
                        data.category = this.snapshot.documentID;
                        return ProductListTile(data);
                      },
                    )
                  ],
                );
              }
            },
          )),
    );
  }
}
