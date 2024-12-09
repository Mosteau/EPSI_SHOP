class Article {
  String nom;
  String description;
  num  prix;
  String image;
  String categories;

  Article(this.nom, this.description, this.prix, this.image, this.categories);

  String prixEuro()=> "$prix€";

}
