import 'dart:convert';

import 'package:cours_flutter/crud/page/product.dart';
import 'package:cours_flutter/crud/product.dart';
import 'package:cours_flutter/crud/product.service.dart';
import 'package:cours_flutter/home.dart';
import 'package:flutter/material.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create product'),
          actions: [Icon(Icons.home)],
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
              ),
              ListTile(
                title: const Text('Product'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductPage()));
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
            TextFormField(
              validator: (value) => value!.isEmpty ? 'Name is required' : null,
              decoration: const InputDecoration(
                hintText: 'Type the name',
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              controller: name,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) =>
                  value!.isEmpty ? 'Description is required' : null,
              decoration: const InputDecoration(
                hintText: 'Type the description',
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              controller: description,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  Product p = Product("", name.text, description.text);
                  ProductService.create(p);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductPage()));
                },
                child: const Text("Create"))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ));
  }
}
