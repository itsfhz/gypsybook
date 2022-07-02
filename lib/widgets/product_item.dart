import 'package:flutter/material.dart';
import 'package:gypsybook/models/world_model.dart';
import 'package:gypsybook/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<World>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            // padding: EdgeInsets.all(kDefaultPaddin),
            // For  demo we use fixed height  and width
            // Now we dont need them
            // height: 180,
            // width: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: kElevationToShadow[4],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Hero(
              tag: "${product.id}",
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProductDetailScreen.routeName,
                    arguments: product.id,
                  );
                },
                child: Image.network(
                  product.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Text(
          // products is out demo list
          product.title!,
        ),
        Text(
          "\$",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );

    // ClipRRect(
    //   borderRadius: BorderRadius.circular(10),
    //   child: Stack(
    //     children: [
    //       GridTile(
    //         child: Image.network(
    //           product.imageUrl!,
    //           fit: BoxFit.cover,
    //         ),
    //         footer: GridTileBar(
    //           backgroundColor: Colors.black87,
    //           // leading: Consumer<Product>(
    //           //   builder: (ctx, product, _) => IconButton(
    //           //     icon: Icon(
    //           //       product.isFavorite ? Icons.favorite : Icons.favorite_border,
    //           //     ),
    //           //     color: Theme.of(context).accentColor,
    //           //     onPressed: () {
    //           //       product.toggleFavoriteStatus();
    //           //     },
    //           //   ),
    //           // ),
    //           title: Text(
    //             product.title!,
    //             textAlign: TextAlign.center,
    //           ),
    //           trailing: IconButton(
    //             icon: Icon(
    //               Icons.shopping_cart,
    //             ),
    //             onPressed: () {
    //               cart.addItem(product.id!, product.price!, product.title!);
    //             },
    //             // color: Theme.of(context).accentColor,
    //           ),
    //         ),
    //       ),
    //       Stack(
    //         children: [
    //           Positioned(
    //             left: 9,
    //             top: 8,
    //             child: Container(
    //               width: 30,
    //               height: 30,
    //               decoration: BoxDecoration(
    //                 color: Colors.black54,
    //                 borderRadius: BorderRadius.circular(50),
    //               ),
    //             ),
    //           ),
    //           Consumer<Course>(
    //             builder: (ctx, product, _) => IconButton(
    //               icon: Icon(
    //                 product.isFavorite ? Icons.favorite : Icons.favorite_border,
    //               ),
    //               color: Theme.of(context).accentColor,
    //               onPressed: () {
    //                 product.toggleFavoriteStatus();
    //               },
    //             ),
    //           ),
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}
