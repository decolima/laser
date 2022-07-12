class Food {
  String imgUrl;
  String desc;
  String name;
  String waitTime;
  num score;
  String cal;
  num price;
  num quantity;
  List<Map<String, String>> ingredients;
  String about;
  bool hightLigth;
  Food(this.imgUrl, this.desc, this.name, this.waitTime, this.score, this.cal,
      this.price, this.quantity, this.ingredients, this.about,
      {this.hightLigth = false});
  static List<Food> generateReccomendFoods() {
    return [
      Food(
          'assets/images/brownie.jpg',
          'dolci soffici al cioccolato',
          'Brownies',
          '50 min',
          5,
          '129 kcal',
          5,
          1,
          [
            {'cioccolato fondente': 'assets/images/Cioccolato.jpg'},
            {'zucchero': 'assets/images/zucchero.jpg'},
            {'burro': 'assets/images/Burro.jpg'},
            {'uova': 'assets/images/uova.jpg'},
            {'farina 00': 'assets/images/farina.jpg'},
            {'cacao amaro in polvere': 'assets/images/cacao.jpg'},
            {
              'sale fino': 'assets/images/sale.jpg' //,
            },
          ],
          'Il brownie, noto anche come chocolate brownie o Manchester brownie, è un biscotto al cioccolato, tipico dessert della cucina statunitense, chiamato così per via del suo colore scuro (brown, marrone), è un biscotto tagliato a piccoli quadrettini. I brownie possono essere ricoperti con della glassa e possono contenere delle scaglie di cioccolato o nocciole e possono essere aromatizzati a vari gusti, come ad esempio vaniglia o menta. Spesso vengono serviti con del latte caldo o del gelato e talvolta con della panna montata, specialmente nei ristoranti. Sono popolari anche come spuntino o come merenda, specialmente accompagnati da un caffè.I principali ingredienti sono farina, zucchero, cioccolato (generalmente fondente, o in abbinamento al cioccolato al latte e al cioccolato bianco), burro, uova e facoltativamente nocciole. Nella ricetta originale non è previsto il lievito. Esistono comunque molte ricette differenti per i brownie e le versioni semplici spesso fungono da introduzione alla cucina.Esiste una versione bianca del brownie, chiamata blondie, preparata senza cacao, spesso con del cioccolato bianco al suo posto.',
          hightLigth: true),
      Food(
          'assets/images/muffin.jpg',
          'muffin con farina di cocco e cuore alla Nutella',
          'muffin al cocco',
          '30 min',
          5,
          '406 kcal',
          3,
          1,
          [
            {'zucchero': 'assets/images/zucchero.jpg'},
            {'uova': 'assets/images/uova.jpg'},
            {'farina di cocco': 'assets/images/farinadicocco.jpg'},
            {'olio': 'assets/images/olio.jpg'},
            {'Nutella': 'assets/images/nutella.jpg'},
            {'lievito': 'assets/images/lievito.jpg'},
            {'latte intero': 'assets/images/latte.jpg'}
          ],
          'I muffin cocco e Nutella sono dei piccoli dolcetti al cocco con un goloso e cremoso cuore di Nutella,'
              'piccole dolcezze per ogni momento della giornata')
    ];
  }

  static List<Food> generatePopularFoods() {
    return [
      Food(
          'assets/images/Limonidolci.jpg',
          'pasticcini più dolci e più amati',
          'limoni dolci ',
          '120 min',
          4.5,
          '363 kcal',
          3,
          1,
          [
            {'farina 00': 'assets/images/farina.jpg'},
            {'uova': 'assets/images/uova.jpg'},
            {'zucchero': 'assets/images/zucchero.jpg'},
            {'latte intero': 'assets/images/latte.jpg'},
            {'lievito': 'assets/images/lievito.jpg'},
            {'scorza di limone': 'assets/images/scorza.jpg'},
            {'olio': 'assets/images/olio.jpg'},
            {'limoncello': 'assets/images/limoncello.jpg'}
          ],
          'morbido biscotto ripieno di crema al limone')
    ];
  }
}
