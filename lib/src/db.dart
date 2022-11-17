import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  savaDados(String nome, String email, String idade, String senha) async {
    SharedPreferences localstorage = await SharedPreferences.getInstance();
    List<String> users = localstorage.getStringList('usuarios') ?? [];
    var dados = {
      'nome': nome,
      'email': email,
      'idade': idade,
      'senha': senha,
      'id': users.length,
    };
    users.add(jsonEncode(dados));
    await localstorage.setStringList('usuarios', users);
    await localstorage.reload();
  }

  Future<Map> buscaDados(int id) async {
    SharedPreferences localstorage = await SharedPreferences.getInstance();
    List<String>? users = localstorage.getStringList('usuarios') ?? [];
    List<Map> dadosTrazidos = [];
    for (var element in users) {
      Map datas = jsonDecode(element);
      dadosTrazidos.add(datas);
    }
    return dadosTrazidos.where((element) => element['id'] == id).first;
  }

  Future<int> login(String email, String senha) async {
    SharedPreferences localstorage = await SharedPreferences.getInstance();
    List<String> users = localstorage.getStringList('usuarios') ?? [];
    List<Map> dadosTrazidos = [];
    for (var element in users) {
      Map datas = jsonDecode(element);
      dadosTrazidos.add(datas);
    }
    List value = dadosTrazidos
        .where(
            (element) => element['email'] == email && element['senha'] == senha)
        .toList();
    return value.first['id'];
  }
}
