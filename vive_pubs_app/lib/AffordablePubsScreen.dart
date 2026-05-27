import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vive_pubs_app/models/pubs.dart';
import 'package:vive_pubs_app/pub_card.dart';

class AffordablePubsScreen extends StatefulWidget {
  const AffordablePubsScreen({Key? key}) : super(key: key);

  @override
  AffordablePubsScreenState createState() => AffordablePubsScreenState();
}

class AffordablePubsScreenState extends State<AffordablePubsScreen> {
  final List<Pubs> _affordablePubs = <Pubs>[];
  late Future<String> futureAffordable;

  @override
  void initState() {
    super.initState();
    futureAffordable = getAffordablePubs(_affordablePubs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Affordable Pubs'),
        backgroundColor: const Color(0xff9aae04),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<String>(
              future: futureAffordable,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: _affordablePubs.length,
                    itemBuilder: (context, index) {
                      return PubCard(_affordablePubs[index]);
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context); // Vuelve a la pantalla anterior (todos los pubs)
              },
              child: const Text('Back to All Pubs'),
            ),
          ),
        ],
      ),
    );
  }
}

Future<String> getAffordablePubs(List<Pubs> targetList, {int maxPrice = 15}) async {
  final response = await http.get(Uri.parse('http://localhost:1337/api/pubs/affordable?maxPrice=$maxPrice'));
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
    throw Exception('Failed to load affordable pubs');
  }
}