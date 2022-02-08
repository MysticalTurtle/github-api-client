import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_api_client/services/github_service.dart';

import '../services/github_service.dart';
import '../services/github_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  GithubApiClientService apiClientService = GithubApiClientService();
  RepoListController controlador = RepoListController();
  GithubApiClientService prueba = GithubApiClientService();

  @override
  Widget build(BuildContext context) {
    List lista = ["Texto prueba 0", "Texto prueba 1"];
    // controlador.controller.sink.add(lista);
    // controlador.test(lista);
    return Scaffold(
      appBar: AppBar(
        title: Text('Github API Client'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Escribe un nombre de usuario existente en Github',
                labelText: 'Usuario',
              ),
              onChanged: _onSearchChanged,
            ),
            Expanded(
              child: StreamBuilder<List>(
                stream: controlador.stream,
                builder: (context, snapshot) {
                  if (true) {
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(apiClientService.getRepositories()[index]),
                          subtitle: Text(apiClientService.getLogin()[index]),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Timer _debounce;
  GithubApiClientService cliente = GithubApiClientService();
  String respuesta;
  List repositorios = [];

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      if (query.isNotEmpty) {
        apiClientService.getRepositories();
        cliente.getRepositories();
        if (respuesta.isNotEmpty) {
          controlador.test(controlador.currentState..add(cliente.getBody()));
        }
      }
    });
  }
}
