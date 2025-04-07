import 'dart:convert';

import 'package:cours_flutter/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MeteoPage extends StatefulWidget {
  const MeteoPage({super.key});

  @override
  State<MeteoPage> createState() => _MeteoPageState();
}

class _MeteoPageState extends State<MeteoPage> {
  var data;
  TextEditingController ville = TextEditingController();
  var httpClient = http.Client();

  Future<void> getMeteo(ville) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$ville&appid=bbc93ffd124ccc42a63ba9240d037955';

    var response = await httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
      });
      print(data);
    }
  }

  @override
  void initState() {
    super.initState();
    getMeteo("Dakar");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meteo'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const Column(
              children: [
                CircleAvatar(
                  radius: 50,
                ),
                Text('John Doe'),
              ],
            ),
            ListTile(
              title: const Text('Accueil'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            ListTile(
              title: const Text('Meteo'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MeteoPage()));
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Veuillez entrer une ville' : null,
                  decoration: const InputDecoration(
                    hintText: 'Entrez la ville',
                    labelText: 'Ville',
                    border: OutlineInputBorder(),
                  ),
                  controller: ville,
                ),
              ),
              IconButton(
                  onPressed: () {
                    getMeteo(ville.text);
                  },
                  icon: const Icon(Icons.search)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (data != null)
            Column(
              children: [
                Text("Pays: ${data['sys']['country']}"),
                Text(
                    "Température: ${(data['main']['temp'] - 273.15).toStringAsFixed(2)}°C"),
                Text("Humidité: ${data['main']['humidity'].toString()}"),
                Text("Vitesse du vent: ${data['wind']['speed'].toString()}"),
                Text("Pression: ${data['main']['pressure'].toString()}"),
                Image.network(
                    "https://openweathermap.org/img/wn/${data['weather'][0]['icon']}@2x.png"),
              ],
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
