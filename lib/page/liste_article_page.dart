import 'dart:convert';

import 'package:epsi_shop/article.dart';
import 'package:epsi_shop/cart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ListeArticlePage extends StatelessWidget {
  ListeArticlePage({super.key});
  final article = Article(
      "Sac à dos",
      "Présentation de la dernière édition de la collection de sacs à dos Nuitée, le Nuitée 2.0. Il est équipé d’un compartiment pour une bouteille et la doublure à l’intérieur est faite de matériaux 100 % recyclés. Compact, mais fonctionnel, il mesure 35 x 26 x 14 cm, dispose d’une capacité de 11 litres, d’un compartiment pour ordinateur portable de 13 pouces, de deux poches zippées et de sangles réglables de 64 à 81 cm. Le sac à dos Nuitée 2.0, en bleu acier avec logo et accessoires de couleur or, est un essentiel chic qui s’accorde facilement à un style décontracté, mais raffiné. Associez le sac à dos Nuitée 2.0 à votre montre et à vos bijoux CLUSE pour un look parfaitement coordonné.",
      125.0,
      "https://cluse.com/cdn/shop/files/CX04403_frontal.jpg?v=1723798776&width=1800",
      "Weareable");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('EPSI Shop'),
            actions: [
              IconButton(
                  onPressed: () {
                    context.go('/panier');
                  }, // Affiche le nombre d'articles dans le panier avec watch
                  icon: Text(context.watch<Cart>().getAll().length.toString()))
            ]),
        body: FutureBuilder<List<Article>>(
            //Appel de la fonction fetchListArticle
            future: fetchListArticle(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return ListArticles(
                  listArticle: snapshot.data!,
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }

  Future<List<Article>> fetchListArticle() async {
    //Récupérer les données depuis fakestore api
    final res = await get(Uri.parse("https://fakestoreapi.com/products"));
    if (res.statusCode == 200) {
      //Les transformer en Liste d'articles
      print("réponse ${res.body}");
      final listMapArticles = jsonDecode(res.body) as List<dynamic>;
      //Mappage de chaque élément de la liste JSON en Article
      return listMapArticles
          .map((map) => Article(map["title"], map["description"], map["price"],
              map["image"], map["category"]))
          .toList();
    }
    //Les renvoyer
    return Future.error("Connexion impossible");
  }
}

class ListArticles extends StatelessWidget {
  final List<Article> listArticle;
  const ListArticles({super.key, required this.listArticle});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listArticle.length,
        itemBuilder: (ctx, index) => ListTile(
              onTap: () => ctx.go("/detail", extra: listArticle[index]),
              leading: Image.network(
                listArticle[index].image,
                height: 80,
                width: 80,
              ),
              title: Text(listArticle[index].nom),
            ));
  }
}
