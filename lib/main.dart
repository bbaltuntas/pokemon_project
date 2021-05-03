import 'package:flutter/material.dart';
import 'package:pokedex_project/pokemon_list.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.teal,
      accentColor: Colors.yellow,
    ),
    debugShowCheckedModeBanner: false,
    home: PokemonPage(),
  ));
}
