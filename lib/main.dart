import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Petición HTTP en Flutter',
      home: PokemonScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PokemonScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  String _pokemonName = '';
  String _pokemonImage = '';
  String _errorMessage = '';
  List<String> _abilities = [];
  final _nameController = TextEditingController(); 

  Future<void> fetchPokemon(String text) async {
    if (text.isEmpty) {
      setState(() {
        _pokemonName = '';
        _pokemonImage = '';
        _errorMessage = '';
        _abilities = [];
      });
      return;
    }

    var url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$text'); 
    try {
      var response = await http.get(url); 
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          _pokemonName = data['name'];
          _pokemonImage = data['sprites']['front_default'];
          _errorMessage = '';
          _abilities = []; 
          for (var abilityData in data['abilities']) {
            _abilities.add(abilityData['ability']['name']);
          }
        });
      } else {
        if (response.statusCode == 404) {
          setState(() {
            _errorMessage = 'No se encontró el Pokémon.';
            _pokemonName = '';
            _pokemonImage = '';
            _abilities = [];
          });
        } else {
          throw Exception('Error al obtener Pokémon. Código de estado: ${response.statusCode}');
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener Pokémon: $e'; 
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon API'),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre del Pokémon',
                ),
                onChanged: (text) {
                  fetchPokemon(text); 
                },
                autofocus: true, 
              ),
            ),
            SizedBox(height: 20),
            if (_pokemonName.isNotEmpty)
              Column(
                children: [
                  Text('Nombre: $_pokemonName', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Image.network(_pokemonImage),
                  SizedBox(height: 20),
                  Text('Habilidades:', style: TextStyle(fontWeight: FontWeight.bold)),
                  for (var ability in _abilities)
                    Text(ability),
                ],
              )
            else if (_errorMessage.isNotEmpty) 
              Text(_errorMessage, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}