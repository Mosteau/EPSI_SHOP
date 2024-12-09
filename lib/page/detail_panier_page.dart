import 'package:epsi_shop/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPanierPage extends StatelessWidget {
  const ListPanierPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();
    final articles = cart.getAll();
    final total = articles.fold<int>(0, (int sum, article) => sum + article.prix.toInt());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Panier"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  title: Text(article.nom),
                  subtitle: Text("${article.prix} €"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      cart.remove(article);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Total : ${total.toStringAsFixed(2)} €",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}