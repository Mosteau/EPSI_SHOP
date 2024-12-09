import 'package:epsi_shop/article.dart';
import 'package:epsi_shop/cart.dart';
import 'package:epsi_shop/page/detail_article_page.dart';
import 'package:epsi_shop/page/detail_panier_page.dart';
import 'package:epsi_shop/page/liste_article_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


// Main pour lancer l'application
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final router = GoRouter(routes:
  [
    GoRoute(
      path: "/",
      builder: (ctx, state) => ListeArticlePage(),
      routes:[
        GoRoute(path: "detail", 
          builder: (ctx, state) => DetailArticlePage(article:state.extra as Article),
          ),
          GoRoute(
            path: "panier",
            builder: (ctx, state) => const ListPanierPage(),
          ),
        ],
      ),
    ],
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Cart(),
      child: MaterialApp.router(
        routerConfig: router,
        title: 'EPSI Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // appBarTheme: AppBarTheme(titleTextStyle: TextStyle(color: Colors.white)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
      ),
    );
  }
}
