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
  double _PrecioTotalActual = 15.0; 

  @override
  void initState() {
    super.initState();
    futureAffordable = getAffordablePubs(_affordablePubs, maxPrice: _PrecioTotalActual.toInt());
  }

  void _reloadPubs() {
    setState(() {
      futureAffordable = getAffordablePubs(_affordablePubs, maxPrice: _PrecioTotalActual.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pubs disponibles'),
        backgroundColor: const Color(0xff9aae04),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Precio maximo:'),
                    Text('${_PrecioTotalActual.toInt()} €'),
                  ],
                ),
                Slider(
                  value: _PrecioTotalActual,
                  min: 0,
                  max: 50,
                  divisions: 50,
                  label: '${_PrecioTotalActual.toInt()} €',
                  onChanged: (value) {
                    setState(() {
                      _PrecioTotalActual = value;
                    });
                  },
                  onChangeEnd: (_) {
                    _reloadPubs();
                  },
                ),
              ],
            ),
          ),
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
                Navigator.pop(context);
              },
              child: const Text('Todos los pubs'),
            ),
          ),
        ],
      ),
    );
  }
}

Future<String> getAffordablePubs(List<Pubs> targetList, {required int maxPrice}) async {
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