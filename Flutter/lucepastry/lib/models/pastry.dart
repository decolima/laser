import 'food.dart';

class Pastry {
  String name;
  String waitTime;
  String label;
  String logoUrl;
  String desc;
  num score;
  Map<String, List<Food>> menu;

  Pastry(this.name, this.waitTime, this.label, this.logoUrl, this.desc,
      this.score, this.menu);

  static Pastry generatePastry() {
    return Pastry('La pasticceria di Luce', '20-30 min', 'Delivery', 'assets/images/logo.jpg',
        'i dolci più buoni che abbia mai mangiato!', 5, {
      'Consigliati dalla casa': Food.generateReccomendFoods(),
      'Popolari': Food.generatePopularFoods(),
      'Torte': [],
      'Biscotti': []
    });
  }
}
