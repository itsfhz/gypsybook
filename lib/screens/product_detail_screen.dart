import 'package:flutter/material.dart';
import 'package:gypsybook/providers/world.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final String? id;
  final String title;
  // final double price;

  ProductDetailScreen(this.id, this.title);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Worlds>(context);
    final products = productsData.items;
    final productId =
        ModalRoute.of(context)!.settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Worlds>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title!),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () async {
                try {
                  await {
                    Provider.of<Worlds>(context, listen: false)
                        .deleteContinent(context, id!, loadedProduct.title!),
                    Navigator.of(context).pop()
                  };
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        "Deleting failed!",
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Theme.of(context).errorColor,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              icon: Icon(Icons.delete_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$loadedProduct.price',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description!,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
