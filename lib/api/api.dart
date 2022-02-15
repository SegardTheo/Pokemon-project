import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/models/list_pokemon.dart';

class Api {
  static const urlListePokemon = "https://pokeapi.co/api/v2/pokemon?limit=151";

  Future<ListePokemon> fetchListePokemon() async{
    final response = await http.get(Uri.parse(urlListePokemon));

    if(response.statusCode == 200){
      return ListePokemon.fromJSON(json.decode(response.body));
    }
    else{
      throw Exception('failed to laod data');
    }
  }

  Future<DetailsPokemon> fetchDetailPokemon(String urlDetail) async{
    final response = await http.get(Uri.parse(urlDetail));

    if(response.statusCode == 200){
      return DetailsPokemon.fromJSON(json.decode(response.body));
    }
    else{
      throw Exception('failed to laod data');
    }
  }
}
