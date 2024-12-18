import 'package:epsi_shop/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPanierPage extends StatelessWidget {
  const ListPanierPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();
    final articles = cart.getAll();
    final totalHT = articles.fold<int>(0, (int sum, article) => sum + article.prix.toInt());
    final totalTTC = totalHT * 1.2;

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
            child: Column(
              children: [
                Text(
                  "Total HT : ${totalHT.toStringAsFixed(2)} €",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  "Total TTC : ${totalTTC.toStringAsFixed(2)} €",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                if (articles.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      child: const Text("Procéder au paiement"),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}