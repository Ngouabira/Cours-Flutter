import 'dart:convert';

import 'package:cours_flutter/crud/page/product.dart';
import 'package:cours_flutter/crud/product.dart';
import 'package:cours_flutter/crud/product.service.dart';
import 'package:cours_flutter/home.dart';
import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  final Product? product;
  const EditProductPage({super.key, this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create product'),
          actions: [Icon(Icons.home)],
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
              controller: name..text = "${widget.product?.name}",
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
              controller: description..text = "${widget.product?.description}",
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  Product p = Product(
                      widget.product?.id ?? "", name.text, description.text);
                  ProductService.update(p);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductPage()));
                },
                child: const Text("Update"))
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
