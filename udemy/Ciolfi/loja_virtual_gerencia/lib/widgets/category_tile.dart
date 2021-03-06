import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/screens/produto_screen.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot category;

  CategoryTile(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(category.data["icon"]),
            backgroundColor: Colors.transparent,
          ),
          title: Text(
            category.data["title"],
            style:
                TextStyle(color: Colors.grey[850], fontWeight: FontWeight.w500),
          ),
          children: <Widget>[
            FutureBuilder<QuerySnapshot>(
              future: category.reference.collection("items").getDocuments(),
              builder: (_, snapshot) {
                if (!snapshot.hasData)
                  return Container();
                else
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      return ListTile(
                        leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(doc.data["images"][0]),
                            backgroundColor: Colors.transparent),
                        trailing:
                            Text("R\$${doc.data["price"].toStringAsFixed(2)}"),
                        title: Text(doc.data["title"]),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_)=>ProdutoScreen(
                              categoryId : category.documentID,
                              produto: doc
                            ))
                          );
                        },
                      );
                    }).toList()
                      ..add(ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.add, color: Colors.pink),
                        ),
                        title: Text("Adicionar"),
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_)=>ProdutoScreen(
                              categoryId : category.documentID
                            ))
                          );
                        },
                      )),
                  );
              },
            )
          ],
        ),
      ),
    );
  }
}
