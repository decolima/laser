import 'package:flutter/material.dart';
    void main() {
      // O método runApp() inicializa o layouta da app
      // MyApp() é um widget que será a raiz da nossa aplicação
      runApp(const MyApp());
    }
    // o widget raiz
    class MyApp extends StatelessWidget {
      const MyApp({Key? key}) : super(key: key);
      // O método build reconstrói a árvore de widegts se houver mudanças
      // e permite o hot reload 
      @override
      Widget build(BuildContext context) {
        // Agora ao ínves de um Container estamos usando o widget MaterialApp 
        // o qual é configurado para dar à nossa app um tema Material
        return MaterialApp(
          // O widget Scaffold define o layouta da home 
          home: Scaffold(
            // Vamos passar um widget AppBar widget para a propriedade appBar do Scaffold
            appBar: AppBar(
              // A prop. AppBar usa um widget Text widget para a sua prop. title
              title: const Text("Explorando Widgets"),
            ),
            // A prop. body do widget Scaffold widget é o conteúdo principal da tela
            // Ao inves de usar diretamente a widget nós vamos definir a widgter em outro
            // método para facilitar o tratamento
            body: myWidgetCol(),
          ),
        );
      }
    }
    // Aqui é onde vamos tratar a widget Text
    Widget myWidget() {
      return const TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(80))),
            hintText: 'Escreva alguma coisa aqui...'
        ),
        style: TextStyle(
                  color: Colors.lime
                  ),
      );
    } 

    Widget myWidget1() {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child:
              Text("Ola terra",
                style: TextStyle(fontSize: 20),
                ),
      );
    }

    Widget myWidget2() {
      return FloatingActionButton(
                backgroundColor: Colors.red,
                elevation: 4.0,
                splashColor: Colors.yellow,
                onPressed: () {
                 
               },
        child: const Text('Meu Botão',
                          textAlign: TextAlign.center,
                          style:TextStyle(color: Colors.white),
                          ),
      );
    } 

Widget myWidgetCol() {
    return Column(
        children: [
                myWidget(),
                myWidget(),
                myWidget2(),
              ]);
} 
