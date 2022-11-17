import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_mobile/src/info_page.dart';
import 'package:trabalho_mobile/src/login.dart';

class Inicio extends StatefulWidget {
  Map dados;
  Inicio({super.key, required this.dados});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: Drawer(
            child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Text("Dados"),
              subtitle: const Text("mais informações..."),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                print("Página de Dados");
                Navigator.pop(context);
                Navigator.pushNamed(context, "/dados");
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text("Informações"),
              subtitle: const Text("mais informações..."),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                print("Mais Informações");
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => const InfoPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Logout"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => const Login()));
                print("Logout");
              },
            )
          ],
        )),
        appBar: AppBar(title: Text('Bem vindo ${widget.dados['nome']}')),
        body: Column(children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text('Bem vindo a Dom Helder'),
          ),
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text('Vejam as imagens de nossa escola'),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            child: CarouselSlider(
              options: CarouselOptions(height: 200, autoPlay: true),
              items: [
                "imagens/campus_3.jpg",
                "imagens/biblioteca2.jpg",
                "imagens/seila.jpg",
                "imagens/Ecos.png"
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Card(
                      child: Image.asset(
                        i,
                        fit: BoxFit.fill,
                        height: 400.0,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            child: const Text('Veja Mais'),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => const InfoPage()));
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Image.asset("imagens/Imagem4.jpg"),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            width: 500,
            child: Text(
                ' Dom Hélder Pessoa Câmara foi um bispo católico, arcebispo emérito de Olinda e Recife. Foi um dos fundadores da Conferência Nacional dos Bispos do Brasil e grande defensor dos direitos humanos durante a ditadura militar no Brasil. Pregava uma Igreja voltada para os pobres e a não-violência.'),
          ),
        ]),
      ),
    );
  }
}
