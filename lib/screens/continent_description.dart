


import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gypsybook/providers/world.dart';
import 'package:gypsybook/screens/add_country_screen.dart';
import 'package:provider/provider.dart';

class ContinentDescription extends StatefulWidget {
  static const routeName = '/product-desc';
  const ContinentDescription({Key? key}) : super(key: key);

  @override
  State<ContinentDescription> createState() => _ContinentDescriptionState();
}

class _ContinentDescriptionState extends State<ContinentDescription> {
  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context)!.settings.arguments as String; // is the id!

    //   final productsData = Provider.of<Worlds>(context);
    // final products = productsData.items;
      final loadedProduct = Provider.of<Worlds>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(EditCountryScreen.routeName);
          }, icon:Icon(Icons.add))
        ],
      title: Text("Description"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: 
                [
                  Row(children: [ ClipRRect(child: Image.network(loadedProduct.imageUrl!,width:40, ),
          borderRadius:BorderRadius.circular(20), ),
            SizedBox(width: 10,),
            Wrap(children: [
                Text( loadedProduct.description!,maxLines: 2,overflow: TextOverflow.ellipsis,)])]),
              ],
        ),
      ),
    );
  }
}