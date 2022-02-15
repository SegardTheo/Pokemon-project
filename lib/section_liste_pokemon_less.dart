import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pokemon/models/list_pokemon.dart';
import 'api/api.dart';
import 'main.dart';

class PageHome extends StatelessWidget {
  // Déclaration API
  late Future<ListePokemon> fetchPokemonListe;

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF383838);
    const colorBarApp = Color(0xFF212121);
    Api api = Api();
    fetchPokemonListe = api.fetchListePokemon();

    return FutureBuilder<ListePokemon>(
      future: fetchPokemonListe,
      builder: (context, moviePopular) {
        if (moviePopular.hasData) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: moviePopular.data!.results!.length,
            itemBuilder: (context, index) {
              Pokemon pokemon = moviePopular.data!.results![index];
              return Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    width: 120.0,
                    child: GestureDetector(
                      onTap: () {
                        print("helo");
                      }
                    ),
                  )
                ],
              );
            },
          );
        } else if (moviePopular.hasError) {

          return Text("${moviePopular.error}");
        }

        return const CircularProgressIndicator();
      },
    );
  }
}