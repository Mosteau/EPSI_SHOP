import 'package:epsi_shop/cart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Page de détail d'un article
class DetailArticlePage extends StatelessWidget {
  const DetailArticlePage({super.key, required this.article});
  
  // ignore: prefer_typing_uninitialized_variables
  final article;

  get style => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Boutique EPSI"),
          actions: [
            IconButton(
                onPressed: () {
                  context.go('/panier');
                },
                icon: Text(context.watch<Cart>().getAll().length.toString()))
          ]),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.network(
            article.image,
            height: 300,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(article.nom,
                          style: Theme.of(context).textTheme.titleLarge),
                      Text(article.prixEuro(),
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 12.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Catégorie : ${article.categories}",
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      article.description,
                      textAlign: TextAlign.start,
                    )),
              ],
            ),
          ),
          OutlinedButton(
              onPressed: () {
                context.read<Cart>().add(article);
              },
              child: const Text("Ajouter au panier"))
          // FutureBuilder(
          //   future: wait5seconds() ,
          //   builder: (context, snapshot){
          //     if(snapshot.hasData){
          //       return  Text("Données téléchargées: ${snapshot.data}");
          //     }else {
          //       return  CircularProgressIndicator();
          //     }
          //   }
          //   )
        ]),
      ),
    );
  }

  Future<bool> wait5seconds() async {
    await Future.delayed(const Duration(seconds: 5));
    return true;
  }
}
