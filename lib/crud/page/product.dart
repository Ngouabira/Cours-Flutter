import 'dart:convert';

import 'package:cours_flutter/crud/page/create_product.dart';
import 'package:cours_flutter/crud/page/edit_product.dart';
import 'package:cours_flutter/crud/product.dart';
import 'package:cours_flutter/crud/product.service.dart';
import 'package:cours_flutter/home.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var data;
  var products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future loadProducts() async {
    data = await ProductService.getAll();
    setState(() {
      products = data.map((item) => Product.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
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
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(products[index].name),
              subtitle: Text(products[index].description),
              leading: const CircleAvatar(),
              trailing: Wrap(children: [
                IconButton(
                  onPressed: () async {
                    await ProductService.delete(products[index].id);
                    loadProducts();
                  },
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProductPage(product: products[index])));
                  },
                  icon: const Icon(Icons.edit),
                )
              ]),
            );
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateProductPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
