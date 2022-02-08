import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_api_client/services/github_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  GithubApiClientService apiClientService = GithubApiClientService();

  @override
  RepoListController controlador = RepoListController();
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
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data[index]),
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
  
  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000),  () async {
      if (query.isNotEmpty) {
        apiClientService.getRepositories(query);
        cliente.getRepositories(query);
        respuesta = await cliente.getRepositories(query);
        controlador.test(controlador.currentState..add(cliente.getBody()));
      }
    });
  }
}
