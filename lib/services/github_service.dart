import 'dart:async';

import 'package:http/http.dart';

class GithubApiClientService {
  String cuerpo;
  final String urlApi = 'https://api.github.com';
  Future<String> getRepositories(String user) async {
    Response response = await get('$urlApi/users/$user/repos');
    if (response.statusCode == 200) {
      print(response.body);
      cuerpo = response.body;
    }
  }
  
  String getBody(){
    return cuerpo;
  }
}

class RepoListController {

  StreamController<List> controller;
  List currentState = [];
  RepoListController() {
    controller = StreamController<List>.broadcast(
      onListen: () {
        controller.sink.add(currentState);
      },
    );
  }

  void test(List lista){
    controller.sink.add(currentState=lista);
  }

  void consulta(){

  }

  Stream<List> get stream => controller.stream;

  void dispose() {
    controller.close();
  }
}