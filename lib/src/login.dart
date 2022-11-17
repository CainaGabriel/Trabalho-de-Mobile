import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_mobile/src/cadastro.dart';
import 'package:trabalho_mobile/src/inicio.dart';
import 'package:trabalho_mobile/src/db.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final localStorage = LocalStorage();
  final senha = TextEditingController();
  final email = TextEditingController();
  final chave = GlobalKey<FormState>();

  login() async {
    try {
      var id = await localStorage.login(email.text, senha.text);
      var dados = await localStorage.buscaDados(id);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Inicio(dados: dados)));
    } catch (e) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Não foi possível logar'),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: chave,
            child: Column(
              children: [
                Image.asset('imagens/dom-logo.png'),
                TextFormField(
                  controller: email,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "E-mail não pode ser nulo";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(hintText: 'E-mail'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: senha,
                  obscureText: true,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Senha não pode ser nula";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(hintText: 'Senha'),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    if (chave.currentState!.validate()) {
                      login();
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(10),
                            right: Radius.circular(10))),
                    child: const Center(
                        child: Text(
                      'Entrar',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Cadastro()));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: 200,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(10),
                            right: Radius.circular(10))),
                    child: const Center(
                        child: Text(
                      'Cadastrar',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
