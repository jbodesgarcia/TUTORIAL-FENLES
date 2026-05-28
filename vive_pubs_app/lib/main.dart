import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vive_pubs_app/models/pubs.dart';
import 'package:vive_pubs_app/pub_card.dart';
import 'package:vive_pubs_app/AffordablePubsScreen.dart';

void main() => runApp(EverisFridayApp());

class EverisFridayApp extends StatefulWidget {
  const EverisFridayApp({Key? key}) : super(key: key);

  @override
  EverisFridayState createState() => EverisFridayState();
}

class EverisFridayState extends State<EverisFridayApp> {
  final List<Pubs> _listPubs = <Pubs>[];
  late Future<String> futurePubs;

  @override
  void initState() {
    super.initState();
    futurePubs = getPubs(_listPubs);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de todos los pubs',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de todos los pubs'),
          backgroundColor: const Color.fromARGB(255, 4, 112, 174),
        ),
        body: Builder(
          builder: (context) => Column(
            children: [
              Expanded(child: _buildPubs()),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Usamos el contexto del Builder para navegar
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AffordablePubsScreen()),
                    );
                  },
                  child: const Text('Pubs disponibles'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPubs() {
    return FutureBuilder<String>(
      future: futurePubs,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: _listPubs.length,
            itemBuilder: (context, index) {
              return PubCard(_listPubs[index]);
            },
          );
        }
      },
    );
  }
}

Future<String> getPubs(List<Pubs> targetList) async {
  final response = await http.get(Uri.parse('http://localhost:1337/api/pubs'));
  if (response.statusCode == 200) {
    final dynamic body = jsonDecode(response.body);
    List<dynamic> pubsListRaw;
    if (body is List<dynamic>) {
      pubsListRaw = body;
    } else if (body is Map<String, dynamic> && body.containsKey('data')) {
      pubsListRaw = body['data'] as List<dynamic>;
    } else {
      throw Exception('Formato de respuesta inesperado');
    }
    targetList.clear();
    for (var raw in pubsListRaw) {
      targetList.add(Pubs.fromJson(raw));
    }
    return "Success!";
  } else {
    throw Exception('Failed to load pubs');
  }
}