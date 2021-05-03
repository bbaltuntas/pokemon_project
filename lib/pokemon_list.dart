import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pokedex_project/models/pokedex.dart';
import 'package:pokedex_project/pokemon_content.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonPage extends StatefulWidget {
  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  Future<Pokedex> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex Project"),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: data,
                builder: (context, AsyncSnapshot<Pokedex> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                        itemCount: snapshot.data.pokemon.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PokemonContent(
                                          pokemon:
                                              snapshot.data.pokemon[index])));
                            },
                            child: Hero(
                              tag: snapshot.data.pokemon[index].id,
                              child: Card(
                                elevation: 4,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      //width: 100,
                                      //height: 100,
                                      child: Expanded(
                                        child: FadeInImage(
                                          placeholder:
                                              AssetImage("assets/loading.gif"),
                                          image: NetworkImage(
                                              snapshot.data.pokemon[index].img),
                                        ),
                                      ),
                                    ),
                                    Text(snapshot.data.pokemon[index].name)
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Text("Error");
                  }
                }),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: data,
                builder: (context, AsyncSnapshot<Pokedex> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                        itemCount: snapshot.data.pokemon.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PokemonContent(
                                          pokemon:
                                              snapshot.data.pokemon[index])));
                            },
                            child: Hero(
                              tag: snapshot.data.pokemon[index].id,
                              child: Card(
                                elevation: 4,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      //width: 100,
                                      //height: 100,
                                      child: Expanded(
                                        child: FadeInImage(
                                          placeholder:
                                              AssetImage("assets/loading.gif"),
                                          image: NetworkImage(
                                              snapshot.data.pokemon[index].img),
                                        ),
                                      ),
                                    ),
                                    Text(snapshot.data.pokemon[index].name)
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Text("Error");
                  }
                }),
          );
        }
      }),
    );
  }

  Future<Pokedex> fetchData() async {
    Pokedex pokedex;
    Uri url = Uri.parse(
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    pokedex = Pokedex.fromJson(jsonData);
    return pokedex;
  }
}
