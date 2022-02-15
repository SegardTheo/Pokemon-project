import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/models/list_pokemon.dart';

import 'api/api.dart';

class SectionListePokemon extends StatefulWidget {
  const SectionListePokemon({Key? key}) : super(key: key);

  @override
  _SectionListePokemonState createState() => _SectionListePokemonState();
}

class _SectionListePokemonState extends State<SectionListePokemon> {
  late Future<ListePokemon> fetchListePokemon;
  Api api = Api();
  
  @override
  void initState() {
    super.initState();
    fetchListePokemon = api.fetchListePokemon();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return FutureBuilder<ListePokemon>(
      future: fetchListePokemon,
      builder: (context, snapshot) {
        //fetchPokemon("pikachu");
        if (snapshot.hasData) {
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data!.results!.length,
            itemBuilder: (BuildContext context, int index) {
              Pokemon pokemon = snapshot.data!.results![index];
              Future<DetailsPokemon> detailsPokemon = api.fetchDetailPokemon(pokemon.urlDetail);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder<DetailsPokemon>(
                      future: detailsPokemon,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          DetailsPokemon? detailPokemon = snapshot.data;
                          if(detailPokemon != null)
                            {
                              return Image.network(detailPokemon.imageDefaut);
                            }
                        }
                        return const CircularProgressIndicator();
                      }
                  ),
                  Expanded(
                    child: Center(child: Text(pokemon.nomPokemon)),
                  ),
                  Expanded(
                    child: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: pokemon.capture,
                      onChanged: (bool? value) {
                        setState(() {
                          pokemon.capture = value;
                        });
                      },
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          );
        } else if (snapshot.hasError) {

          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
