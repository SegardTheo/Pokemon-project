
import 'package:pokemon/api/api.dart';

class ListePokemon{
  int? _count;
  String? _nextUrl;
  String? _previous;
  List<Pokemon>? _pokemons = [];

  ListePokemon.fromJSON(Map<String, dynamic> parsedJson) {
    if(parsedJson.isNotEmpty)
      {
        print("#####################################################");
        _count = parsedJson['count'];
        _nextUrl = parsedJson['next'];
        _previous = parsedJson['previous'];

        List<Pokemon> temp = [];

        if(parsedJson['results'] != null)
        {
          for(int i=0; i< parsedJson['results'].length; i++){
            Pokemon result = Pokemon(parsedJson['results'][i]);
            temp.add(result);
          }
        }

        _pokemons = temp;
      }
  }

  List<Pokemon>? get results => _pokemons;

  int? get count => _count;

  String? get nextUrl => _nextUrl;

  String? get previous => _previous;
}

class Pokemon {
  String _nomPokemon = "";
  String _urlDetail = "";
  bool? _capture = false;

  Pokemon(parsedJson) {
    _nomPokemon = parsedJson['name'];
    _urlDetail = parsedJson['url'];
  }

  String get nomPokemon =>_nomPokemon;
  String get urlDetail =>_urlDetail;

  bool? get capture {
    return _capture;
  }

  void set capture(bool? captureParam) {
    _capture = captureParam;
  }
}

class DetailsPokemon
{
  String _imageDefaut = "";

  DetailsPokemon();

  DetailsPokemon.fromJSON(Map<String, dynamic> parsedJson) {
    if(parsedJson['sprites'] != null)
    {
      _imageDefaut = parsedJson['sprites']["front_default"];
    }
  }

  String get imageDefaut =>_imageDefaut;
}