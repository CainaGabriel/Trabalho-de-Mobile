import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:trabalho_mobile/src/db.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final localStorage = LocalStorage();
  final nome = TextEditingController();
  final email = TextEditingController();
  final idade = TextEditingController();
  final senha = TextEditingController();

  cadastro() async {
    try {
      await localStorage.savaDados(
          nome.text, email.text, idade.text, senha.text);
      chave.currentState!.reset();
      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content:
                  Text('Cadastro feito com sucesso!\nVolte a tela de login'),
            );
          });
    } catch (e) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Não foi possível cadastrar'),
            );
          });
    }
  }

  final chave = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cadastro'),
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
                  controller: nome,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Informe seu nome";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(hintText: 'Nome'),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: email,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Informe seu e-mail";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(hintText: 'E-mail'),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: idade,
                  inputFormatters: [MaskTextInputFormatter(mask: "##")],
                  keyboardType: TextInputType.number,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Informe sua idade";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(hintText: 'Idade'),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: senha,
                  obscureText: true,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Informe sua senha";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(hintText: 'Senha'),
                ),
                const SizedBox(
                  height: 60,
                ),
                GestureDetector(
                  onTap: () {
                    if (chave.currentState!.validate()) {
                      cadastro();
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
