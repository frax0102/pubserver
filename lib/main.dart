import 'package:rovafinale/pub_card.dart';
import 'package:flutter/material.dart';

import 'models/pubs.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

void main() => runApp(const EverisFridayApp());

class EverisFridayApp extends StatefulWidget {
  const EverisFridayApp({super.key});

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
      title: 'Everis Fridays Pub',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Everis Fridays Pub'),
          backgroundColor: const Color(0xff9aae04),
        ),
        body: Center(
          child: _buildPubs(),
        ),
      ),
    );
  }

  Widget _buildPubs() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            // ignore: unnecessary_null_comparison
            projectSnap.hasData == null) {
          return Container();
        }
        return ListView.builder(
          itemCount: _listPubs.length,
          itemBuilder: (context, index) {
            return PubCard(_listPubs[index]);
          },
        );
      },
      future: futurePubs,
    );
  }
}

// ignore: no_leading_underscores_for_local_identifiers
Future<String> getPubs(_listPubs) async {
  

  final Response response = await http.get(Uri.parse('http://192.168.1.195:1337/api/pubs'));


  
  if (response.statusCode == 200) {
    List<dynamic> pubsListRaw = jsonDecode(response.body);
    for (var i = 0; i < pubsListRaw.length; i++) {
      _listPubs.add(Pubs.fromJson(pubsListRaw[i]));
    }

    return "Success!";
  } else {

    throw Exception('Failed to load data');
  }
  
 
}