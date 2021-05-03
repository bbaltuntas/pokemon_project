import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex_project/models/pokedex.dart';

class PokemonContent extends StatefulWidget {
  Pokemon pokemon;

  PokemonContent({this.pokemon});

  @override
  _PokemonContentState createState() => _PokemonContentState();
}

class _PokemonContentState extends State<PokemonContent> {
  PaletteGenerator paletteGenerator;
  Color dominantColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dominantColor = Colors.orangeAccent;
    findColor();
  }

  void findColor() {
    Future<PaletteGenerator> fPaletGenerator =
        PaletteGenerator.fromImageProvider(NetworkImage(widget.pokemon.img));
    fPaletGenerator.then((value) {
      paletteGenerator = value;
      // debugPrint("secilen renk :" + paletteGenerator.dominantColor.color.toString());

      if (paletteGenerator != null && paletteGenerator.vibrantColor != null) {
        dominantColor = paletteGenerator.vibrantColor.color;
        setState(() {});
      } else if (paletteGenerator != null &&
          paletteGenerator.dominantColor != null) {
        dominantColor = paletteGenerator.dominantColor.color;
        setState(() {});
      } else {
        debugPrint("NULL COLOR");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dominantColor,
      appBar: AppBar(
        title: Text(widget.pokemon.name),
        elevation: 0,
        backgroundColor: dominantColor,
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Stack(
            children: <Widget>[
              Positioned(
                left: 20,
                top: 70,
                right: 20,
                height: MediaQuery.of(context).size.height * 2 / 3,
                //width: MediaQuery.of(context).size.width - 20,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  elevation: 5,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: 110,
                      ),
                      Text(
                        widget.pokemon.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Text("Height: " + widget.pokemon.height),
                      Text("Weight: " + widget.pokemon.weight),
                      Text(
                        "Type",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.pokemon.type
                            .map((type) => Chip(label: Text(type)))
                            .toList(),
                      ),
                      Text(
                        "Next Evolution",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: widget.pokemon.nextEvolution != null
                              ? widget.pokemon.nextEvolution.map((evolution) {
                                  return Chip(label: Text(evolution.name));
                                }).toList()
                              : [Text("Last Version")]),
                      Text(
                        "Weaknesses",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: widget.pokemon.weaknesses
                              .map((weakness) => Chip(
                                    label: Text(weakness),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: widget.pokemon.id,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(widget.pokemon.img))),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              width: MediaQuery.of(context).size.width - 60,
              height: MediaQuery.of(context).size.height * (3 / 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Hero(
                      tag: widget.pokemon.id,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(widget.pokemon.img))),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 1 / 20,
                          ),
                          Text(
                            widget.pokemon.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          Text("Height: " + widget.pokemon.height),
                          Text("Weight: " + widget.pokemon.weight),
                          Text(
                            "Type",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: widget.pokemon.type
                                .map((type) => Chip(label: Text(type)))
                                .toList(),
                          ),
                          Text(
                            "Next Evolution",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: widget.pokemon.nextEvolution != null
                                  ? widget.pokemon.nextEvolution
                                      .map((evolution) {
                                      return Chip(label: Text(evolution.name));
                                    }).toList()
                                  : [Text("Last Version")]),
                          Text(
                            "Weaknesses",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: widget.pokemon.weaknesses
                                .map((weakness) => Chip(
                                      label: Text(weakness),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
