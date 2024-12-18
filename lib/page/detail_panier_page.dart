import 'package:epsi_shop/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    child: ListTile(
                      title: Text(article.nom),
                      subtitle: Text("${article.prix} €"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          cart.remove(article);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (articles.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FaIcon(FontAwesomeIcons.ccVisa),
                      FaIcon(FontAwesomeIcons.ccMastercard),
                      FaIcon(FontAwesomeIcons.ccPaypal),
                      FaIcon(FontAwesomeIcons.applePay),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Total HT : ${totalHT.toStringAsFixed(2)} €",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Total TTC : ${totalTTC.toStringAsFixed(2)} €",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
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